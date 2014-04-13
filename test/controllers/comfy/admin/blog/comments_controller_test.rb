require_relative '../../../../test_helper'

class Comfy::Admin::Blog::CommentsControllerTest < ActionController::TestCase
  
  def setup
    @site     = comfy_cms_sites(:default)
    @blog     = comfy_blog_blogs(:default)
    @post     = comfy_blog_posts(:default)
    @comment  = comfy_blog_comments(:default)
  end
  
  def test_get_index
    get :index, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert_template :index
    assert assigns(:comments)
    assert !assigns(:post)
  end
  
  def test_get_index_for_post
    get :index, :site_id => @site, :blog_id => @blog, :post_id => @post
    assert_response :success
    assert_template :index
    assert assigns(:post)
    assert assigns(:comments)
  end
  
  def test_publish
    assert @comment.is_published?
    xhr :patch, :toggle_publish, :site_id => @site, :blog_id => @blog, :id => @comment
    assert_response :success
    @comment.reload
    assert !@comment.is_published?
    
    xhr :patch, :toggle_publish, :site_id => @site, :blog_id => @blog, :id => @comment
    assert_response :success
    @comment.reload
    assert @comment.is_published?
  end
  
  def test_destroy
    assert_difference 'Comfy::Blog::Comment.count', -1 do
      delete :destroy, :site_id => @site, :blog_id => @blog, :id => @comment
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Comment deleted', flash[:success]
    end
  end
  
  def test_destroy_failure
    delete :destroy, :site_id => @site, :blog_id => @blog, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Comment not found', flash[:error]
  end

end