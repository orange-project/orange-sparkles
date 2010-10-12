require "rubygems"
require '../../lib/orange-sparkles'
app = Orange::SparklesApp.app do
  main_user           "therabidbanana@gmail.com"
  main_users          ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
  development_mode    true
  s3_bucket           "orange-test"
  site_name           "foobar"
end
class Bar < Orange::Carton
  id
  admin do
    text :foo
    text :bar
    text :baz
    fulltext :qux
  end
end

class Foo < Orange::ModelResource
  use Bar
  def stack_init
    
  end
end

app.orange.load(Foo.new)
app.orange.options[:s3_bucket] = "orange-test"
run app
