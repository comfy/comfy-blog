require File.expand_path('../../test_helper', File.dirname(__FILE__))

class SofaBlog::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_with_unpublished
    sofa_blog_posts(:default).update_attribute(:is_published, false)
    get :index
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_with_pagination
    get :index, :page => 99
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_show
    get :show, :id => sofa_blog_posts(:default)
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_with_unpublished
    sofa_blog_posts(:default).update_attribute(:is_published, false)
    get :show, :id => sofa_blog_posts(:default)
    assert_response 404
  end
  
  def test_get_show_invalid
    get :show, :id => 'invalid'
    assert_response 404
  end
  
end
