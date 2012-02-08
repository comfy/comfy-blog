require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Blog::ApplicationHelperTest < ActionView::TestCase
  
  def test_blog_post_path
    assert_equal '/2012/01/default-title', blog_post_path(blog_posts(:default))
    assert_equal 'http://test.host/2012/01/default-title', blog_post_url(blog_posts(:default))
  end
  
end
