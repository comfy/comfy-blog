module ComfyBlog
  class Configuration
    
    # Title of your Blog
    attr_accessor :title
    
    # What is your blog all about
    attr_accessor :description
    
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
    
    # Comments can be automatically approved/published by changing this setting
    # Default is false.
    attr_accessor :auto_publish_comments
    
    # Comments can be fully handled by Disqus. Set this config to use it.
    attr_accessor :disqus_shortname
    
    # If you want to include the routes manually set this to false
    attr_accessor :use_default_routes
    
    # Configuration defaults
    def initialize
      @title                  = 'ComfyBlog'
      @description            = 'A Simple Blog'
      @admin_route_prefix     = 'admin'
      @public_route_prefix    = ''
      @admin_controller       = 'ApplicationController'
      @form_builder           = 'ComfyBlog::FormBuilder'
      @public_layout          = 'application'
      @posts_per_page         = 10
      @auto_publish_comments  = false
      @disqus_shortname       = nil
      @use_default_routes     = true
    end
    
  end
end