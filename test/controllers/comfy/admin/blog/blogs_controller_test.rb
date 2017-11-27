require_relative '../../../../test_helper'

class Comfy::Admin::Blog::BlogsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
  end

  def test_get_index
    r :get, comfy_admin_blogs_path(@site)
    assert_response :success
    assert assigns(:blogs)
    assert_template :index
  end

  def test_get_index_with_no_blogs
    Comfy::Blog::Blog.delete_all
    r :get, comfy_admin_blogs_path(@site)
    assert_response :redirect
    assert_redirected_to action: :new
  end

  def test_get_new
    r :get, new_comfy_admin_blog_path(@site)
    assert_response :success
    assert assigns(:blog)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blogs']"
  end

  def test_get_edit
    r :get, edit_comfy_admin_blog_path(@site, @blog)
    assert_response :success
    assert assigns(:blog)
    assert_template :edit
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}']"
  end

  def test_get_edit_failure
    r :get, edit_comfy_admin_blog_path(@site, 'invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Blog not found', flash[:danger]
  end

  def test_creation
    assert_difference -> {Comfy::Blog::Blog.count} do
      r :post, comfy_admin_blogs_path(@site), params: {blog: {
        label:        'Test Blog',
        identifier:   'test-blog',
        path:         'test-blog',
        description:  'Test Description'
      }}
      blog = Comfy::Blog::Blog.last
      assert_response :redirect
      assert_redirected_to action: :edit, id: blog
      assert_equal 'Blog created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference -> {Comfy::Blog::Blog.count} do
      r :post, comfy_admin_blogs_path(@site), params: {blog: {}}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Blog', flash[:danger]
    end
  end

  def test_update
    r :put, comfy_admin_blog_path(@site, @blog), params: {blog: {
      label: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :edit, id: @blog
    assert_equal 'Blog updated', flash[:success]
    @blog.reload
    assert_equal 'Updated', @blog.label
  end

  def test_update_failure
    r :put, comfy_admin_blog_path(@site, @blog), params: {blog: {
      label: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Blog', flash[:danger]
    @blog.reload
    refute_equal '', @blog.label
  end

  def test_destroy
    assert_difference -> {Comfy::Blog::Blog.count}, -1 do
      r :delete, comfy_admin_blog_path(@site, @blog)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Blog deleted', flash[:success]
    end
  end
end
