# require 'coveralls'
# Coveralls.wear!('rails')

ENV['RAILS_ENV'] = 'test'

require_relative '../config/environment'
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

# Load fixtures from the engine
ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)

class ActiveSupport::TestCase
  
  fixtures :all
  
  setup :reset_config
  
  def reset_config
    ComfyBlog.configure do |config|
      config.posts_per_page = 10
      config.auto_publish_comments = false
      config.disqus_shortname = nil
    end
  end
  
  # Example usage:
  #   assert_has_errors_on @record, :field_1, :field_2
  def assert_errors_on(record, *fields)
    unmatched = record.errors.keys - fields.flatten
    assert unmatched.blank?, "#{record.class} has errors on '#{unmatched.join(', ')}'"
    unmatched = fields.flatten - record.errors.keys
    assert unmatched.blank?, "#{record.class} doesn't have errors on '#{unmatched.join(', ')}'"
  end
  
end

class ActionController::TestCase
  
  setup :set_basic_auth
  
  # CMS by default is going to prompt with basic auth request
  def set_basic_auth
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64('username:password')}"
  end
  
end