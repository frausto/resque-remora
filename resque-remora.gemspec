# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: resque-remora 0.3.0.rc2 ruby lib

Gem::Specification.new do |s|
  s.name = "resque-remora".freeze
  s.version = "0.3.0.rc2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["nolan frausto".freeze]
  s.date = "2019-12-27"
  s.description = "resque plugin that allows you to attach information when a job is put in redis, and to do whatever you want with the information when it is popped off the resque queue".freeze
  s.email = "nrfrausto@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/resque-remora.rb",
    "lib/resque/plugins/remora.rb",
    "lib/resque/plugins/remora/push_pop.rb",
    "resque-remora.gemspec",
    "spec/redis-test.conf",
    "spec/resque/plugins/remora/push_pop_spec.rb",
    "spec/resque/plugins/remora_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/jobs.rb"
  ]
  s.homepage = "http://github.com/frausto/resque-remora".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "resque plugin that allows you to attach information to a resque job and retrieve it when it gets popped of the queue".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resque>.freeze, ["< 3.0", ">= 1.10"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<yajl-ruby>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<json>.freeze, ["~> 1.5.3"])
    else
      s.add_dependency(%q<resque>.freeze, ["< 3.0", ">= 1.10"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<yajl-ruby>.freeze, ["~> 1.2"])
      s.add_dependency(%q<json>.freeze, ["~> 1.5.3"])
    end
  else
    s.add_dependency(%q<resque>.freeze, ["< 3.0", ">= 1.10"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<yajl-ruby>.freeze, ["~> 1.2"])
    s.add_dependency(%q<json>.freeze, ["~> 1.5.3"])
  end
end

