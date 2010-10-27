require "rubygems"
require '../../lib/orange-sparkles'
require 'aws/s3'

class Bar < Orange::Carton
  id
  admin do
    text :foo
    text :bar
    text :baz
    fulltext :qux
    markdown :banana
  end
end

class Baz < Orange::SparklesResource
  use Bar
  call_me :baz
end

app = (Orange::SparklesApp.app {
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    false
  s3_bucket           "orange-test"
  site_name           "foobar"
  # load  Bar
})

app.orange.load(Baz.new)
run app