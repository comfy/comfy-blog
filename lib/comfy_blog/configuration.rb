module ComfyBlog
  class Configuration

    # application layout to be used to index blog posts
    attr_accessor :app_layout

    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page

    # Configuration defaults
    def initialize
      @posts_per_page = 10
      @app_layout     = 'comfy/blog/application'
    end

  end
end
