require "rubygems"
require '../../lib/orange-sparkles'
require 'aws/s3'
Orange.autoload!

run (Orange::SparklesApp.app {
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    false
  s3_bucket           "orange-test"
  site_name           "foobar"
  load BarResource.new
})