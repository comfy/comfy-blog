$:.push File.expand_path("../lib", __FILE__)

require 'comfy_blog/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'comfy_blog'
  s.version     = ComfyBlog::VERSION
  s.authors     = ["Oleg Khabarov", "The Working Group Inc"]
  s.email       = ["oleg@khabarov.ca"]
  s.homepage    = "http://github.com/comfy/comfy-blog"
  s.summary     = "Simple Blog Engine for ComfortableMexicanSofa"
  s.description = "Simple Blog Engine for ComfortableMexicanSofa"
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.add_dependency 'comfortable_mexican_sofa', '>= 1.11.0'
end
