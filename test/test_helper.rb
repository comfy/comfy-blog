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
  
  # Example usage:
  #   assert_exception_raised                                 do ... end
  #   assert_exception_raised ActiveRecord::RecordInvalid     do ... end
  #   assert_exception_raised Plugin::Error, 'error_message'  do ... end
  def assert_exception_raised(exception_class = nil, error_message = nil, &block)
    exception_raised = nil
    yield
  rescue => exception_raised
  ensure
    if exception_raised
      if exception_class
        assert_equal exception_class, exception_raised.class, exception_raised.to_s
      else
        assert true
      end
      assert_equal error_message, exception_raised.to_s if error_message
    else
      flunk 'Exception was not raised'
    end
  end
  
end

class ActionController::TestCase
  
  setup :set_basic_auth
  
  # CMS by default is going to prompt with basic auth request
  def set_basic_auth
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64('username:password')}"
  end
  
end