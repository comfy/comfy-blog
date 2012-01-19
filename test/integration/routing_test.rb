require File.expand_path('../test_helper', File.dirname(__FILE__))

class RoutingTest < ActionDispatch::IntegrationTest
  
  def setup
    reset_config
    Rails.application.reload_routes!
  end
  
  def test_admin_route_prefix
    ComfyBlog.config.admin_route_prefix = 'custom-admin'
    Rails.application.reload_routes!
    
    get '/custom-admin/blog/posts'
    assert_response :success
  end
  
  def test_public_route_prefix
    ComfyBlog.config.public_route_prefix = 'blog'
    Rails.application.reload_routes!
    
    get '/blog'
    assert_response :success
  end
  
end