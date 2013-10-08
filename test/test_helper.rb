require 'coveralls'
Coveralls.wear!('rails')

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)

class ActiveSupport::TestCase
  
  fixtures :all
  
  setup :reset_config
  
  # Example usage:
  #   assert_has_errors_on @record, :field_1, :field_2
  def assert_errors_on(record, *fields)
    unmatched = record.errors.keys - fields.flatten
    assert unmatched.blank?, "#{record.class} has errors on '#{unmatched.join(', ')}'"
    unmatched = fields.flatten - record.errors.keys
    assert unmatched.blank?, "#{record.class} doesn't have errors on '#{unmatched.join(', ')}'"
  end
  
  def reset_config
    ComfyBlog.configure do |config|
      config.posts_per_page = 10
      config.auto_publish_comments = false
      config.disqus_shortname = nil
    end
  end
  
end