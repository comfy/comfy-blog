require File.expand_path('../config/application', __FILE__)

ComfyBlog::Application.load_tasks

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'comfy_blog'
    gem.homepage    = 'http://github.com/comfy/comfy-blog'
    gem.license     = 'MIT'
    gem.summary     = 'ComfyBlog is a blog engine for Rails 3.1 apps (and ComfortableMexicanSofa)'
    gem.description = ''
    gem.email       = 'oleg@twg.ca'
    gem.authors     = ['Oleg Khabarov', 'The Working Group Inc.']
    gem.version     = File.read('VERSION').chomp
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end