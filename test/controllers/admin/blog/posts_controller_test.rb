require_relative '../../../test_helper'

class Admin::Blog::PostsControllerTest < ActionController::TestCase
  
  def setup
    @site = cms_sites(:default)
  end
  
  def test_get_index
    get :index, :site_id => @site
    assert_response :success
    assert assigns(:posts)
    assert_template :index
  end
  
  def test_get_new
    get :new, :site_id => @site
    assert_response :success
    assert assigns(:post)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blog/posts']"
  end
  
  def test_creation
    assert_difference 'Blog::Post.count' do
      post :create, :site_id => @site, :post => {
        :title    => 'Test',
        :content  => 'Content'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => assigns(:post)
      assert_equal 'Blog Post created', flash[:success]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Post.count' do
      post :create, :site_id => @site, :post => { }
      assert_response :success
      assert_template :new
      assert assigns(:post)
      assert_equal 'Failed to create Blog Post', flash[:error]
    end
  end
  
  def test_get_edit
    get :edit, :site_id => @site, :id => blog_posts(:default)
    assert_response :success
    assert_template :edit
    assert assigns(:post)
  end
  
  def test_get_edit_failure
    get :edit, :site_id => @site, :id => 'bogus'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Blog Post not found', flash[:error]
  end
  
  def test_update
    post = blog_posts(:default)
    put :update, :site_id => @site, :id => post, :post => {
      :title => 'Updated Post'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => assigns(:post)
    assert_equal 'Blog Post updated', flash[:success]
    
    post.reload
    assert_equal 'Updated Post', post.title
  end
  
  def test_update_failure
    post = blog_posts(:default)
    put :update, :site_id => @site, :id => post, :post => {
      :title => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Blog Post', flash[:error]
    
    post.reload
    assert_not_equal '', post.title
  end
  
  def test_destroy
    assert_difference 'Blog::Post.count', -1 do
      delete :destroy, :site_id => @site, :id => blog_posts(:default)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Blog Post removed', flash[:success]
    end
  end
  
end