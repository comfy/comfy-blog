require 'bundler'
Bundler.setup

require 'rake/testtask'

Rake::TestTask.new(:ci) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

require_relative 'config/application'
ComfyBlog::Application.load_tasks
