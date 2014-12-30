module ComfyBlog
  class Configuration

    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page

    # Enable/disable comments on posts
    # Default is true
    attr_accessor :allow_comments

    # Comments can be automatically approved/published by changing this setting
    # Default is false.
    attr_accessor :auto_publish_comments

    # A default author can be specified for posts
    attr_accessor :default_author

    # Configuration defaults
    def initialize
      @posts_per_page         = 10
      @allow_comments         = true
      @auto_publish_comments  = false
      @default_author         = nil
    end

  end
end
