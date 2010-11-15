require "rubygems"
require '../../../orange-core/lib/orange-core'
require '../../../orange-more/lib/orange-more'
require '../../lib/orange-sparkles'
require 'aws/s3'
require 'omniauth'
Orange.autoload!
run (Orange::SparklesApp.app {
  omniauth_twitter :on => true
  omniauth_facebook :on => true
  omniauth_github :on => true
  omniauth_google_apps :domain => "orangesparkleball.com", :icon => "/assets/public/images/osb_badge.png", 'main_users' => true
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    false
  s3_bucket           "orange-test"
  site_name           "foobar"
  
  load BarResource.new
})