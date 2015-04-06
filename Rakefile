# encoding: utf-8
$LOAD_PATH.unshift 'lib'

require 'rubygems'
require 'bundler'
require 'resque/tasks'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "resque-remora"
  gem.homepage = "http://github.com/frausto/resque-remora"
  gem.license = "MIT"
  gem.summary = %Q{resque plugin that allows you to attach information to a resque job and retrieve it when it gets popped of the queue}
  gem.description = %Q{resque plugin that allows you to attach information when a job is put in redis, and to do whatever you want with the information when it is popped off the resque queue}
  gem.email = "nrfrausto@gmail.com"
  gem.authors = ["nolan frausto"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "resque-remora #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
