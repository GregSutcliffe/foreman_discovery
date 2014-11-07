module Host::AutodiscoveryExtensions
  extend ActiveSupport::Concern

  module InstanceMethods

    # return auto provision rule or false when not present
    def find_discovery_rule
      Rails.logger.debug "Finding auto discovery rule for host #{name} (#{id})"
      # for each discovery rule ordered by priority
      DiscoveryRule.where(:enabled => true).order(:priority).each do |rule|
        max = rule.max_count
        usage = rule.hosts.size
        Rails.logger.debug "Applying rule #{rule.name} (#{rule.id}) [#{usage}/#{max}]"
        # if the rule has free slots
        if max == 0 || usage < max
          # try to match the search
          if Host::Discovered.where(:id => id).search_for(rule.search).size > 0
            Rails.logger.info "Match found for host #{name} (#{id}) rule #{rule.name} (#{rule.id})"
            return rule
          end
        else
          Rails.logger.info "Skipping drained rule #{rule.name} (#{rule.id}) with max set to #{rule.max_count}"
        end
      end
      return false
    end

  end
end
