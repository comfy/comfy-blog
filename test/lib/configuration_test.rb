require_relative '../test_helper'

class ConfigurationTest < ActiveSupport::TestCase

  def test_configuration
    assert config = ComfyBlog.configuration
    assert_equal 10,    config.posts_per_page
    assert_equal true, config.allow_comments
    assert_equal false, config.auto_publish_comments
    assert_equal nil,   config.default_author
  end

  def test_initialization_overrides
    ComfyBlog.config.posts_per_page = 5
    assert_equal 5, ComfyBlog.config.posts_per_page
  end

end