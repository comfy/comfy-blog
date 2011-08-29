require 'sofa_blog'
require 'rails'

module SofaBlog
  class Engine < Rails::Engine
    initializer 'sofa_blog.configuration' do |app|
      if defined?(ComfortableMexicanSofa)
        # applying configuraion
        SofaGallery.configure do |conf|
          conf.admin_controller = 'CmsAdmin::BaseController'
          conf.form_builder     = 'ComfortableMexicanSofa::FormBuilder'
        end
        # applying nav elements
        ComfortableMexicanSofa::ViewHooks.add(:navigation, '/sofa_blog_admin/navigation')
      end
    end
  end
end