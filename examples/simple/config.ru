#\-s thin -p 5432
require "rubygems"
require '../../lib/orange-sparkles'
app = Orange::SparklesApp.app
app.orange.options["main_user"] = ["therabidbanana@gmail.com"]
app.orange.options["main_users"] = ["therabidbanana@gmail.com", "david@orangesparkleball.com"]
app.orange.options[:development_mode] = true
class Bar < Orange::Carton
  id
  admin do
    text :foo
    text :bar
    text :baz
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