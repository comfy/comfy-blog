require File.expand_path('../test_helper', File.dirname(__FILE__))

class ConfigurationTest < ActiveSupport::TestCase
  
  def test_configuration
    assert config = ComfyBlog.configuration
    assert_equal 'ComfyBlog',               config.title
    assert_equal 'A Simple Blog',           config.description
    assert_equal 'admin',                   config.admin_route_prefix
    assert_equal '',                        config.public_route_prefix
    assert_equal 'ApplicationController',   config.admin_controller
    assert_equal 'ComfyBlog::FormBuilder',  config.form_builder
    assert_equal 10,                        config.posts_per_page
    assert_equal false,                     config.auto_publish_comments
    assert_equal nil,                       config.disqus_shortname
  end
  
  def test_initialization_overrides
    ComfyBlog.config.admin_route_prefix = 'new-admin'
    assert_equal 'new-admin', ComfyBlog.config.admin_route_prefix
  end
  
  def test_disqus_enabled?
    assert !ComfyBlog.disqus_enabled?
    ComfyBlog.config.disqus_shortname = 'test'
    assert ComfyBlog.disqus_enabled?
  end
  
end