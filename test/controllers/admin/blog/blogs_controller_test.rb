require_relative '../../../test_helper'

class Admin::Blog::BlogsControllerTest < ActionController::TestCase
  
  def setup
    @site = cms_sites(:default)
    @blog = blog_blogs(:default)
  end
  
  def test_get_index
    get :index, :site_id => @site
    assert_response :success
    assert assigns(:blogs)
    assert_template :index
  end
  
  def test_get_new
    get :new, :site_id => @site
    assert_response :success
    assert assigns(:blog)
    assert_template :new
    assert_select "form[action=/admin/sites/#{@site.id}/blogs]"
  end
  
  def test_get_edit
    get :edit, :site_id => @site, :id => @blog
    assert_response :success
    assert assigns(:blog)
    assert_template :edit
    assert_select "form[action=/admin/sites/#{@site.id}/blogs/#{@blog.id}]"
  end
  
  def test_get_edit_failure
    get :edit, :site_id => @site, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Blog not found', flash[:error]
  end
  
  def test_creation
    assert_difference 'Blog::Blog.count' do
      post :create, :site_id => @site, :blog => {
        :label        => 'Test Blog',
        :identifier   => 'test-blog',
        :path         => 'test-blog',
        :description  => 'Test Description'
      }
      blog = Blog::Blog.last
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => blog
      assert_equal 'Blog created', flash[:success]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Blog.count' do
      post :create, :site_id => @site, :blog => { }
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Blog', flash[:error]
    end
  end
  
  def test_update
    put :update, :site_id => @site, :id => @blog, blog: {
      :label => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => @blog
    assert_equal 'Blog updated', flash[:success]
    @blog.reload
    assert_equal 'Updated', @blog.label
  end
  
  def test_update_failure
    put :update, :site_id => @site, :id => @blog, :blog => {
      :label => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Blog', flash[:error]
    @blog.reload
    refute_equal '', @blog.label
  end
  
  def test_destroy
    assert_difference 'Blog::Blog.count', -1 do
      delete :destroy, :site_id => @site, :id => @blog
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Blog deleted', flash[:success]
    end
  end
end