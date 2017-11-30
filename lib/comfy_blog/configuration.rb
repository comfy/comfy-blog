module ComfyBlog
  class Configuration

    # Application layout to be used to index blog posts.
    # Default is 'comfy/blog/application'
    attr_accessor :app_layout

    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page

    # Auto-setting parameter derived from the routes
    attr_accessor :public_blog_path

    # Configuration defaults
    def initialize
      @posts_per_page   = 10
      @app_layout       = 'comfy/blog/application'
      @public_blog_path = nil
    end

  end
end
