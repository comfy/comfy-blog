require 'comfy_blog'
require 'rails'

module ComfyBlog
  class Engine < Rails::Engine
    initializer 'comfy_blog.configuration' do |app|
      if defined?(ComfortableMexicanSofa)
        # Applying configuraion
        ComfyBlog.configure do |conf|
          conf.admin_route_prefix = "cms-admin" # ComfortableMexicanSofa.config.admin_route_prefix
          conf.admin_controller = 'CmsAdmin::BaseController'
          conf.form_builder = 'ComfortableMexicanSofa::FormBuilder'
        end
        # Adding view hooks
        ComfortableMexicanSofa::ViewHooks.add(:navigation, '/admin/blog/navigation')
      end
    end
  end
end