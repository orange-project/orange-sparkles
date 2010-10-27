class Orange::SparklesResource < Orange::ModelResource
  extend ClassInheritableAttributes
  cattr_accessor :tabbed
  def self.tab(text = nil)
    self.tabbed = text
  end
  
  def stack_init
    orange[:sparkles].add_tab(@my_orange_name, self.class.tabbed) if self.class.tabbed || (self.class.tabbed == nil)
  end
end