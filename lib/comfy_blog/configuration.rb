module ComfyBlog
  class Configuration
    # Default url to access admin area is http://yourhost/cms-admin/ 
    # You can change 'cms-admin' to 'admin', for example.
    attr_accessor :admin_route_prefix
    
    # Prefix of the url where blog posts are served from. If you wish to
    # serve posts from /blog change this setting to 'blog'. Default is blank.
    attr_accessor :public_route_prefix
    
    # Controller that should be used for admin area
    attr_accessor :admin_controller
    
    # Form builder
    attr_accessor :form_builder
    
    # Layout used for public posts/comments
    attr_accessor :public_layout
    
    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page
    
    # Configuration defaults
    def initialize
      @admin_route_prefix   = 'admin'
      @public_route_prefix  = ''
      @admin_controller     = 'ApplicationController'
      @form_builder         = 'ComfyBlog::FormBuilder'
      @public_layout        = 'application'
      @posts_per_page       = 10
    end
  end
end