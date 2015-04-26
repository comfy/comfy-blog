module ComfyBlog
  class Configuration

    # Number of posts per page. Default is 10
    attr_accessor :posts_per_page

    # Comments can be automatically approved/published by changing this setting
    # Default is false.
    attr_accessor :auto_publish_comments

    # A default author can be specified for posts
    attr_accessor :default_author

    # A proc to be called when a post cannot be found
    attr_accessor :post_not_found

    # Configuration defaults
    def initialize
      @posts_per_page         = 10
      @auto_publish_comments  = false
      @default_author         = nil
      @post_not_found = Proc.new { render :cms_page => '/404', :status => 404 }
    end

  end
end
