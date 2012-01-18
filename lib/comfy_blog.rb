# Loading engine only if this is not a standalone installation
unless defined? ComfyBlog::Application
  require File.expand_path('sofa_blog/engine', File.dirname(__FILE__))
end

[ 'comfy_blog/core_ext/string',
  'comfy_blog/configuration',
  'comfy_blog/form_builder'
].each do |path|
  require File.expand_path(path, File.dirname(__FILE__))
end

module ComfyBlog
  class << self
    
    def configure
      yield configuration
    end
    
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
    
  end
end