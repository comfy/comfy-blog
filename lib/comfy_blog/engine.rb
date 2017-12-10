require "rubygems"
require "rails"
require "comfortable_mexican_sofa"
require "comfy_blog"

module ComfyBlog

  module CmsSiteExtensions
    extend ActiveSupport::Concern
    included do
      has_many :blog_posts,
        class_name: "Blog::Post",
        dependent:  :destroy
    end
  end

  class Engine < ::Rails::Engine
    initializer "comfy_blog.configuration" do |app|
      ComfortableMexicanSofa::ViewHooks.add(:navigation, "/comfy/admin/blog/partials/navigation")
      config.to_prepare do
        Comfy::Cms::Site.send :include, ComfyBlog::CmsSiteExtensions
      end
    end
  end
end
