#\-s thin -p 5432
require "rubygems"
require '../../lib/orange-sparkles'

app = Orange::SparklesApp.app
app.orange.options["main_user"] = "therabidbanana@gmail.com"
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
    orange[:admin].add_link("tabs", {:resource => :foo, :text => "Foobarbazyo"})
  end
end

app.orange.load(Foo.new)

run app