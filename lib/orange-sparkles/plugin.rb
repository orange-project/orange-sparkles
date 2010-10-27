require 'orange-sparkles/sparkles_app_resource'
require 'orange-sparkles/sparkles_resource'
module Orange::Plugins
  class Sparkles < Base
    assets_dir      File.join(File.dirname(__FILE__), 'assets')
    views_dir       File.join(File.dirname(__FILE__), 'views')
    templates_dir   File.join(File.dirname(__FILE__), 'templates')
    resource SparklesAppResource.new
  end
end

Orange.plugin(Orange::Plugins::Sparkles.new)

