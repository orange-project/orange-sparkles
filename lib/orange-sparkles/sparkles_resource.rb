class SparklesResource < Orange::Resource
  call_me :sparkles
  def stylesheets
    orange.options["stylesheets"] || []
  end
  def javascripts
    orange.options["javascripts"] || []
  end
  def site_name(packet, default = "An Orange Site")
    packet['site'] ? packet['site'].name : default
  end
  def sidebar?
    orange.options["sidebar_on", false]
  end
end