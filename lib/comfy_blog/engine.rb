require 'rubygems'
require 'rails'
require 'comfortable_mexican_sofa'
require 'comfy_blog'

module ComfyBlog
  
  module CmsSiteExtentions
    extend ActiveSupport::Concern
    included do 
      has_many :blog_posts,
        :class_name => 'Blog::Post',
        :dependent  => :destroy
    end
  end
  
  class Engine < ::Rails::Engine
    initializer 'comfy_blog.configuration' do |app|
      ComfortableMexicanSofa::ViewHooks.add(:navigation, '/admin/blog/partials/navigation')
      Cms::Site.send :include, ComfyBlog::CmsSiteExtentions
    end
  end
end