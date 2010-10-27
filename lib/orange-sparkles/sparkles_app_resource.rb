require 'extlib/mash'

class Orange::Carton
  # Define a helper for input type="text" type database stuff
  # Show in a context if wrapped in one of the helpers
  def self.markdown(name, opts = {})
    add_scaffold(name, :markdown, DataMapper::Property::Text, opts.with_defaults(:lazy => true))
  end
  
  # Declares a SparklesResource subclass that scaffolds this carton
  # The Subclass will have the name of the carton followed by "Resource"
  def self.as_sparkles_resource
    name = self.to_s
    eval <<-HEREDOC
    class ::#{name}Resource < Orange::SparklesResource
      use #{name}
      call_me :#{name.downcase}
    end
    HEREDOC
  end
  def self.as_sparkle_resource
    as_sparkles_resource
  end
end

class SparklesAppResource < Orange::Resource
  call_me :sparkles
  
  def init
    @tabs = []
  end
  def stack_init
    orange[:scaffold].add_scaffold_type(:markdown) do |name, val, opts|
      packet = opts[:packet]
      opts = opts.with_defaults({:value => '', :label => false, :show => false, :wrap_tag => 'div'})
      if opts[:show]
        packet.markdown(val || '')
      else
        val = '' if val.blank?
        val.gsub!("\n", '&#010;')
        ret = "<textarea name='#{opts[:model_name]}[#{name}]' class='markdown-editor'>#{val}</textarea>"
        ret = "<label for=''>#{opts[:display_name]}</label><br />" + ret if opts[:label]
        ret = "<#{opts[:wrap_tag]}>#{ret}</#{opts[:wrap_tag]}>" if opts[:wrap_tag]
        ret
      end
    end
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
    @tabs << {:resource => resource, :text => (text || resource.to_s.capitalize)}
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