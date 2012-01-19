require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Admin::Blog::CommentsControllerTest < ActionController::TestCase
  
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
  
  def test_publish
    comment = blog_comments(:default)
    comment.update_attribute(:is_published, false)
    xhr :put, :publish, :id => comment
    assert_response :success
    
    comment.reload
    assert comment.is_published
  end
  
  def test_destroy
    assert_difference 'Blog::Comment.count', -1 do
      xhr :delete, :destroy, :id => blog_comments(:default)
      assert_response :success
    end
  end

end