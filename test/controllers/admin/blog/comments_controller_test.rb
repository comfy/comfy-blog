require_relative '../../../test_helper'

class Admin::Blog::CommentsControllerTest < ActionController::TestCase
  
  def setup
    @site = cms_sites(:default)
  end
  
  def test_get_index
    get :index, :site_id => @site
    assert_response :success
    assert_template :index
    assert assigns(:comments)
    assert !assigns(:post)
  end
  
  def test_get_index_for_post
    get :index, :site_id => @site, :post_id => blog_posts(:default)
    assert_response :success
    assert_template :index
    assert assigns(:post)
    assert assigns(:comments)
  end
  
  def test_publish
    comment = blog_comments(:default)
    assert comment.is_published?
    xhr :patch, :toggle_publish, :site_id => @site, :id => comment
    assert_response :success
    comment.reload
    assert !comment.is_published?
    
    xhr :patch, :toggle_publish, :site_id => @site, :id => comment
    assert_response :success
    comment.reload
    assert comment.is_published?
  end
  
  def test_destroy
    assert_difference 'Blog::Comment.count', -1 do
      delete :destroy, :site_id => @site, :id => blog_comments(:default)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Comment deleted', flash[:success]
    end
  end
  
  def test_destroy_failure
    delete :destroy, :site_id => @site, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Comment not found', flash[:error]
  end

end