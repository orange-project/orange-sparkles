class OrangeSparkles < Thor::Group
  include Thor::Actions
  
  argument :name
  
  def create_config_ru
    create_file "#{name}/config.ru", <<-DOC
#\-s thin -p 5432
begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  Gem.clear_paths
  require "bundler"
  Bundler.setup
end

require 'orange-sparkles'

run Orange::SparklesApp.app
DOC
  end
  
  def create_gemfile
    create_file "#{name}/Gemfile", <<-DOC
# Add custom gems like this:
# gem 'gemname'
#
# See http://gembundler.com/ for more details
source "http://rubygems.org"
gem "orange"
gem "orange-sparkles"
DOC
  end
  
  def create_config_yml
    create_file "#{name}/config.yml", <<-DOC
database: mysql://osb:orange@localhost/orange_#{name}
main_user: orange@orangesparkleball.com # Set to a valid google account email or OpenID
db_no_auto_upgrade: false  # set to true to disable DataMapper.auto_upgrade! calls

development_mode: yes   # set false or no to turn off debug bar

google_analytics_key: "gawhatever"

DOC
  end
  
  def assets_dir
    empty_directory "#{name}/assets/public/css"
    empty_directory "#{name}/assets/public/js"
    empty_directory "#{name}/assets/public/images"
  end
  
  def public_dir
    empty_directory "#{name}/public"
  end
  
  def create_readme
    create_file "#{name}/README.markdown", <<-DOC

Dreamhost Orange Install Process:
=================================


Getting Custom Rubygems Going
-----------------------------
Get a custom version of ruby gems installed:

[http://www.blog.bridgeutopiaweb.com/post/installing-ruby-gems-on-dreamhost/](http://www.blog.bridgeutopiaweb.com/post/installing-ruby-gems-on-dreamhost/)

Install bundler:

    gem install bundler

Use Gemfile to get bundled gems

    bundle install

Repeat `bundle install` until it actually works (Dreamhost kills bundle install sometimes)


Configuration
-------------
Set appropriate vars for running on Dreamhost

In config.ru, set localized gems path (at top) or bundler won't work:

    ENV['GEM_PATH'] = '__LOCAL/GEM/PATH/HERE__:/usr/lib/ruby/gems1.8/'

In config.yml, set the appropriate database connection string:

    database: mysql://USER:PASS@HOST/DB_NAME


DOC
  end
end
