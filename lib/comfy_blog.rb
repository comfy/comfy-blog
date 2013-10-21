require_relative 'comfy_blog/version'
require_relative 'comfy_blog/engine'
require_relative 'comfy_blog/configuration'
require_relative 'comfy_blog/routing'

module ComfyBlog
  
  class << self
    
    # Modify Blog configuration
    # Example:
    #   ComfyBlog.configure do |config|
    #     config.posts_per_page = 5
    #   end
    def configure
      yield configuration
    end
    
    # Accessor for ComfyBlog::Configuration
    def configuration
      @configuration ||= ComfyBlog::Configuration.new
    end
    alias :config :configuration
    
  end
  
end
