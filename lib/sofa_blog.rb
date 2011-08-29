# Loading engine only if this is not a standalone installation
unless defined? SofaBlog::Application
  require File.expand_path('sofa_blog/engine', File.dirname(__FILE__))
end

require File.expand_path('sofa_blog/configuration', File.dirname(__FILE__))

module SofaBlog
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