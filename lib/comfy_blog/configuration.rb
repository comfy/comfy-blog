module ComfyBlog
  class Configuration

    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page

    # Configuration defaults
    def initialize
      @posts_per_page         = 10
    end

  end
end
