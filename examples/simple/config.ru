require "rubygems"
require '../../lib/orange-sparkles'


class Bar < Orange::Carton
  id
  admin do
    text :foo
    text :bar
    text :baz
    fulltext :qux
  end
end

run (Orange::SparklesApp.app {
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    false
  s3_bucket           "orange-test"
  site_name           "foobar"
  load  Bar
})