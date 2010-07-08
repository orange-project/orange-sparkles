#-s thin -p 5432
require "rubygems"
require 'orange-sparkles'

app = Orange::SparklesApp.app
app.orange.options["database"] = "mysql://osb:orange@localhost/orange_sparkles-test"
app.orange.options["main_user"] = "therabidbanana@gmail.com"

run app