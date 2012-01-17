require File.expand_path('../test_helper', File.dirname(__FILE__))

class ConfigurationTest < ActiveSupport::TestCase
  
  def test_configuration
    assert config = SofaBlog.configuration
    assert_equal 'admin',                             config.admin_route_prefix
    assert_equal '',                                  config.public_route_prefix
    assert_equal 'ApplicationController',             config.admin_controller
    assert_equal 'ActionView::Helpers::FormBuilder',  config.form_builder
    assert_equal 10,                                  config.posts_per_page
  end
  
  def test_initialization_overrides
    SofaBlog.config.admin_route_prefix = 'new-admin'
    assert_equal 'new-admin', SofaBlog.config.admin_route_prefix
  end
  
end