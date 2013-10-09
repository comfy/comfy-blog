require 'rubygems'
require 'comfortable_mexican_sofa'
require 'comfy_blog'
require 'rails'
require 'kaminari'

module ComfyBlog
  class Engine < ::Rails::Engine
    initializer 'comfy_blog.configuration' do |app|
      ComfortableMexicanSofa::ViewHooks.add(:navigation, '/admin/blog/partials/navigation')
    end
  end
end