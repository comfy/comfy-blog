#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

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
    gem.authors     = ['Jack Neto', 'Oleg Khabarov', 'The Working Group Inc.']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end