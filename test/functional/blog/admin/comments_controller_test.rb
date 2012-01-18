require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Blog::Admin::CommentsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:comments)
    assert !assigns(:post)
  end
  
  def test_get_index_for_post
    get :index, :post_id => blog_posts(:default)
    assert_response :success
    assert_template :index
    assert assigns(:post)
    assert assigns(:comments)
  end

end