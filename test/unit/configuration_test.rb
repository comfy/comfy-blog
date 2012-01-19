require File.expand_path('../test_helper', File.dirname(__FILE__))

class ConfigurationTest < ActiveSupport::TestCase
  
  def test_configuration
    assert config = ComfyBlog.configuration
    assert_equal 'admin',                   config.admin_route_prefix
    assert_equal '',                        config.public_route_prefix
    assert_equal 'ApplicationController',   config.admin_controller
    assert_equal 'ComfyBlog::FormBuilder',  config.form_builder
    assert_equal 10,                        config.posts_per_page
    assert_equal false,                     config.auto_publish_comments
  end
  
  def test_initialization_overrides
    ComfyBlog.config.admin_route_prefix = 'new-admin'
    assert_equal 'new-admin', ComfyBlog.config.admin_route_prefix
  end
  
end