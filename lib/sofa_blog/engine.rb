require 'rails'
require 'comfortable_mexican_sofa'
require "sofa_blog"
require "rails"

module SofaBlog
  class Engine < Rails::Engine
    initializer 'sofa_blog' do |app|
      ComfortableMexicanSofa::ViewHooks.add(:navigation, 'sofa_blog/nav')
      ComfortableMexicanSofa::ViewHooks.add(:html_head, 'sofa_blog/head')
      
      ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :blog => [
        'comfortable_mexican_sofa/blog/content'
      ]
    end
  end
end