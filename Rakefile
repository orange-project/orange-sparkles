require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "orange-sparkles"
    gem.summary = "Adding some prettiness to orange-core"
    gem.description = "This gem is a "
    gem.email = "therabidbanana@gmail.com"
    gem.homepage = "http://github.com/orange-project/orange-sparkles"
    gem.authors = ["David Haslem"]
    gem.add_dependency "orange-core", ">= 0.5.7"
    gem.add_dependency "orange-more", ">= 0.5.7"
    gem.add_dependency "maruku", ">= 0"
    gem.add_dependency "rack-abstract-format", ">= 0"
    # gem.add_development_dependency "rspec", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "orange-sparkles #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
