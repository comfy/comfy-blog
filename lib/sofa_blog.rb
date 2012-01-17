# Loading engine only if this is not a standalone installation
unless defined? SofaBlog::Application
  require File.expand_path('sofa_blog/engine', File.dirname(__FILE__))
end

[ 'sofa_blog/core_ext/string',
  'sofa_blog/configuration',
  'sofa_blog/form_builder'
].each do |path|
  require File.expand_path(path, File.dirname(__FILE__))
end

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