tab_content = '<div class="tab-pane" id="discovery">
  <%= select_f f, :discovery_id, SmartProxy.with_features("Discovery"), :id, :name,
      { :include_blank => _("None") }, :label =>_("Discovery Proxy"),
      :help_inline => _("Discovery Proxy to use within this subnet for managing connection to discovered hosts")
  %>

  <%= select_f f, :pxe_template_id, ConfigTemplate.where(:template_kind_id => TemplateKind.find("PXELinux").id),
      :id, :name, { :include_blank => _("None")}, :label => _("PXE Template"),
      :help_inline => _("PXE Template to use for the pxelinux.cfg/default file on this subnet")
  %>
</div>'

Deface::Override.new(
  :virtual_path  => "subnets/_form",
  :name          => "add_discovery_tab_to_subnet_form",
  :insert_bottom => 'ul',
  :text          =>  '<li><a href="#discovery" data-toggle="tab"><%= _("Discovery") %></a></li>'
)

Deface::Override.new(
  :virtual_path  => "subnets/_form",
  :name          => "add_discovery_tab_content",
  :insert_bottom => 'div.tab-content',
  :text          =>  tab_content
)
