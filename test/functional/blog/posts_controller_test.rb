require File.expand_path('../../test_helper', File.dirname(__FILE__))

class Blog::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_with_unpublished
    blog_posts(:default).update_attribute(:is_published, false)
    get :index
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_with_pagination
    get :index, :page => 99
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_tagged
    flunk
  end
  
  def test_get_index_for_categorized
    flunk
  end
  
  def test_get_index_for_year_archive
    flunk
  end
  
  def test_get_index_for_month_archive
    flunk
  end
  
  def test_get_show
    post = blog_posts(:default)
    get :show, :year => post.year, :month => post.month, :slug => blog_posts(:default).slug
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_with_unpublished
    post = blog_posts(:default)
    post.update_attribute(:is_published, false)
    get :show, :year => post.year, :month => post.month, :slug => blog_posts(:default).slug
    assert_response 404
  end
  
  def test_get_show_invalid
    get :show, :year => '1999', :month => '99', :slug => 'invalid'
    assert_response 404
  end
  
end
