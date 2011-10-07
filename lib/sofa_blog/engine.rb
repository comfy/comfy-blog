require 'sofa_blog'
require 'rails'

module SofaBlog
  class Engine < Rails::Engine
    initializer 'sofa_blog.configuration' do |app|
      if defined?(ComfortableMexicanSofa)
        # Applying configuraion
        SofaBlog.configure do |conf|
          conf.admin_route_prefix = ComfortableMexicanSofa.config.admin_route_prefix
          conf.admin_controller = 'CmsAdmin::BaseController'
          conf.form_builder = 'ComfortableMexicanSofa::FormBuilder'
        end
        # Adding view hooks
        ComfortableMexicanSofa::ViewHooks.add(:navigation, '/sofa_blog/admin/navigation')
        ComfortableMexicanSofa::ViewHooks.add(:html_head, '/sofa_blog/admin/html_head')
      end
    end
  end
end