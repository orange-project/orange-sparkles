require 'extlib/mash'
class SparklesAppResource < Orange::Resource
  call_me :sparkles
  
  def init
    @tabs = []
  end
  
  def stylesheets
    orange.options["sparkles.stylesheets"] || []
  end
  def javascripts
    orange.options["sparkles.javascripts"] || []
  end
  def site_name(packet, default = "An Orange Site")
    packet['site'] ? packet['site'].name : default
  end
  def sidebar?
    orange.options["sidebar_on"] || false
  end
  def add_tab(resource, text = nil)
    @tabs << {:resource => resource, :text => (text || resource.to_s)}
  end
  def tabs
    tabs = orange.options["sparkles.tabs"] || []
    tabs = (tabs + @tabs) unless @tabs.blank?
    tabs.collect{|hash| Mash.new(hash)} || []
  end
  def default_style?
    orange.options["sparkles.default_style"] || stylesheets.empty?
  end
end