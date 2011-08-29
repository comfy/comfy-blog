module SofaBlog
  class Configuration
    # Default url to access admin area is http://yourhost/cms-admin/ 
    # You can change 'cms-admin' to 'admin', for example.
    attr_accessor :admin_route_prefix
    
    # Controller that should be used for admin area
    attr_accessor :admin_controller
    
    # Form builder
    attr_accessor :form_builder
    
    # Configuration defaults
    def initialize
      @upload_options     = { }
      @admin_route_prefix = 'admin'
      @admin_controller   = 'ApplicationController'
      @form_builder       = 'ActionView::Helpers::FormBuilder'
    end
    
  end
end