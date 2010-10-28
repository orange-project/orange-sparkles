class OrangeSparkles < Thor::Group
  include Thor::Actions
  
  argument :name
  class_options :edge => true, :type => :boolean, :aliases => "-e"
  class_options :heroku => false, :type => :boolean, :aliases => "-h"
  class_options :mate => true, :type => :boolean, :aliases => "-m"
  class_options :bundler => true, :type => :boolean, :aliases => "-b"
  
  def create_config_ru
    create_file "#{name}/config.ru", <<-DOC
require "rubygems"
require "bundler"
Bundler.setup
Bundler.require
Orange.autoload!

run (Orange::SparklesApp.app{
  main_users ["example-google-email-address@gmail.com"]
})
DOC
  end
  
  def create_gemfile
    create_file "#{name}/Gemfile", <<-DOC
# Add custom gems like this:
# gem 'gemname'
#
# See http://gembundler.com/ for more details
source "http://rubygems.org"
gem "i18n"
gem "aws-s3"
gem "orange-core"#{options[:edge] ? ', :git => "git://github.com/therabidbanana/orange-core.git"' : ''}
gem "orange-more"#{options[:edge] ? ', :git => "git://github.com/therabidbanana/orange-more.git"' : ''}
gem "orange-sparkles"#{options[:edge] ? ', :git => "git://github.com/orange-project/orange-sparkles.git"' : ''}
gem "dm-postgres-adapter"
gem "dm-sqlite-adapter"
DOC
  end
  
  def create_config_yml
    create_file "#{name}/config.yml", <<-DOC

# google_analytics_key: "gawhatever"

DOC
  end
  
  def assets_dir
    empty_directory "#{name}/assets/public/css"
    empty_directory "#{name}/assets/public/js"
    empty_directory "#{name}/assets/public/images"
  end
  
  def create_readme
    create_file "#{name}/README.markdown", <<-DOC

Heroku Orange Install Process:
=================================

Install bundler:

    gem install bundler

Use Gemfile to get bundled gems

    bundle install




DOC
  end
  
  
  def create_templates_dir
    empty_directory "#{name}/templates"
  end
  
  def git_init
    puts "running git init"
    `cd #{name}; git init`
  end
  
  def mate_it
    if options[:mate]
      hername = name.gsub(/[^0-9a-zA-Z-]/, '-')
      puts "opening project in textmate..."
      `mate #{name}`
    end
  end
  
  def run_bundler
    if options[:bundler]
      puts "running bundle install..."
      `gem install bundler`
      `cd #{name}; bundle install`
    end
  end
  
  def heroku_create
    if options[:heroku]
      hername = "osb" + name.gsub(/[^0-9a-zA-Z-]/, '-')
      puts "creating #{hername} on heroku..."
      `gem install heroku`
      `cd #{name}; heroku create #{hername}`
    end
  end
  
  
end
