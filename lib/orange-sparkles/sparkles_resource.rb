class Orange::SparklesResource < Orange::ModelResource
  extend ClassInheritableAttributes
  cattr_accessor :tabbed, :auto_sitemap
  viewable :summary
  
  def self.tab(text = nil)
    self.tabbed = text
  end
  
  def self.auto_sitemap!
    self.auto_sitemap = true
  end
  
  def exposed?(packet)
    []
  end
  
  def stack_init
    orange[:sparkles].add_tab(@my_orange_name, self.class.tabbed) if self.class.tabbed || (self.class.tabbed == nil)    
    orange.register(:sitemap_created) do |opts|
      packet = opts[:packet]
      site_id = opts[:site_id]
      orange[:sitemap, true].add_route_for(packet,
        :orange_site_id => site_id, 
        :resource => @my_orange_name, 
        :resource_action => :do_route,
        :slug => @my_orange_name.to_s, 
        :link_text => @my_orange_name.to_s.capitalize,
        :show_in_nav => true
        )
    end if (self.class.auto_sitemap || (self.class.auto_sitemap == nil)) 
  end
  
  def route_with_resource(packet, *args)
    route = orange[:sitemap, true].url_for(packet,
      :resource => @my_orange_name, 
      :resource_action => :do_route
      )
    route + args.compact.join('/')
  end
  
  def do_route(packet, opts = {})
    resource_path = packet['route.resource_path']
    parts = resource_path.split('/')
    route(packet, parts, opts = {})
  end
  
  def route(packet, route_parts, opts = {})
    if route_parts.blank?
      list(packet, opts)
    else
      show(packet, opts.with_defaults({:resource_id => route_parts.first}))
    end
  end
end