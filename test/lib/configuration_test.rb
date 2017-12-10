require_relative "../test_helper"

class ConfigurationTest < ActiveSupport::TestCase

  def test_configuration
    assert config = ComfyBlog.configuration
    assert_equal  10,                       config.posts_per_page
    assert_equal "comfy/blog/application",  config.app_layout
    assert_equal "blog",                    config.public_blog_path
  end

  def test_initialization_overrides
    ComfyBlog.config.posts_per_page = 5
    assert_equal 5, ComfyBlog.config.posts_per_page
  end
end
