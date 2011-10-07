require File.expand_path('../config/application', __FILE__)

SofaBlog::Application.load_tasks

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'sofa_blog'
    gem.homepage    = 'http://github.com/twg/sofa-blog'
    gem.license     = 'MIT'
    gem.summary     = 'SofaBlog is a blog engine for Rails 3.1 apps (and ComfortableMexicanSofa)'
    gem.description = ''
    gem.email       = 'jack@theworkinggroup.ca'
    gem.authors     = ['Jack Neto', 'The Working Group Inc.']
    gem.version     = File.read('VERSION').chomp
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end