require "rubygems"
require '../../../orange-core/lib/orange-core'
require '../../../orange-more/lib/orange-more'
require '../../lib/orange-sparkles'
require 'aws/s3'
Orange.autoload!

run (Orange::SparklesApp.app {
  omniauth_twitter :on => true
  omniauth_facebook :on => true
  omniauth_github :on => true
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    false
  s3_bucket           "orange-test"
  site_name           "foobar"
  
  load BarResource.new
})