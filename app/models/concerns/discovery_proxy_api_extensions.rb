module Concerns
  module DiscoveryProxyApiExtensions
    extend ActiveSupport::Concern
    include ::Foreman::Renderer

    included do
      alias_method_chain :create_default, :per_subnet
    end

    # This is a bit hacky - it's the right place to alias_chain, but we don't have
    # access to the subnet or even the proxy in the Foreman db, only the proxy URL.
    # This should be done in core at some point, it'll be much nicer to extend
    # ConfigTemplate.build_pxe_default, but we can't alias that without reimplementing
    # the entire method.

    def create_default_with_per_subnet(args)
      logger.info "ForemanDiscovery: Checking for Subnet-specific PXE template"

      uri      = URI.parse(@url)
      proxy    = SmartProxy.find_by_url("#{uri.scheme}://#{uri.host}:#{uri.port}")
      template = ConfigTemplate.find(Subnet.where(:tftp_id => proxy.id).map(&:pxe_template_id).uniq.first)

      if template
        logger.debug "ForemanDiscovery: Found #{template.name} for TFTP proxy #{proxy.name}"
        args[:menu] = render_safe(template.template, [:default_template_url], {:profiles => @profiles})
      else
        logger.debug "ForemanDiscovey: No specific template for TFTP Proxy #{proxy.name}, rendering default"
      end

      create_default_without_per_subnet(args)
    end
  end
end
