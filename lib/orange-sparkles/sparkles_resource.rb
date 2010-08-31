require 'extlib/mash'
class SparklesResource < Orange::Resource
  call_me :sparkles
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
  def tabs
    tabs = orange.options["sparkles.tabs"] || []
    tabs.collect{|hash| Mash.new(hash)} || []
  end
  def default_style?
    orange.options["sparkles.default_style"] || false
  end
end