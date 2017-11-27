require_relative '../../../../test_helper'

class Comfy::Admin::Blog::PostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
    @post = comfy_blog_posts(:default)
  end

  def test_get_index
    r :get, comfy_admin_blog_posts_path(@site, @blog)
    assert_response :success
    assert assigns(:posts)
    assert_template :index
  end

  def test_get_index_with_no_posts
    Comfy::Blog::Post.delete_all
    r :get, comfy_admin_blog_posts_path(@site, @blog)
    assert_response :redirect
    assert_redirected_to action: :new
  end

  def test_get_index_with_category
    category = @site.categories.create!(
      label:            'Test Category',
      categorized_type: 'Comfy::Blog::Post'
    )
    category.categorizations.create!(categorized: @post)

    r :get, comfy_admin_blog_posts_path(@site, @blog), params: {categories: category.label}
    assert_response :success
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).count
    assert assigns(:posts).first.categories.member? category
  end

  def test_get_index_with_category_invalid
    r :get, comfy_admin_blog_posts_path(@site, @blog), params: {categories: 'invalid'}
    assert_response :success
    assert assigns(:posts)
    assert_equal 0, assigns(:posts).count
  end

  def test_get_new
    r :get, new_comfy_admin_blog_post_path(@site, @blog)
    assert_response :success
    assert assigns(:post)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/posts']"
  end

  def test_creation
    assert_difference -> {Comfy::Blog::Post.count} do
      r :post, comfy_admin_blog_posts_path(@site, @blog), params: {post: {
        title:        'Test Post',
        slug:         'test-post',
        published_at: 2.days.ago.to_s(:db),
        is_published: '1'
      }}
      assert_response :redirect
      assert_redirected_to action: :edit, id: assigns(:post)
      assert_equal 'Blog Post created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference ->{Comfy::Blog::Post.count} do
      r :post, comfy_admin_blog_posts_path(@site, @blog), params: {post: {}}
      assert_response :success
      assert_template :new
      assert assigns(:post)
      assert_equal 'Failed to create Blog Post', flash[:danger]
    end
  end

  def test_get_edit
    r :get, edit_comfy_admin_blog_post_path(@site, @blog, @post)
    assert_response :success
    assert_template :edit
    assert assigns(:post)
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/posts/#{@post.id}']"
  end

  def test_get_edit_failure
    r :get, edit_comfy_admin_blog_post_path(@site, @blog, 'invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Blog Post not found', flash[:danger]
  end

  def test_update
    r :put, comfy_admin_blog_post_path(@site, @blog, @post), params: {post: {
      title: 'Updated Post'
    }}
    assert_response :redirect
    assert_redirected_to action: :edit, id: assigns(:post)
    assert_equal 'Blog Post updated', flash[:success]

    @post.reload
    assert_equal 'Updated Post', @post.title
  end

  def test_update_failure
    r :put, comfy_admin_blog_post_path(@site, @blog, @post), params: {post: {
      title: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Blog Post', flash[:danger]

    @post.reload
    assert_not_equal '', @post.title
  end

  def test_destroy
    assert_difference -> {Comfy::Blog::Post.count}, -1 do
      r :delete, comfy_admin_blog_post_path(@site, @blog, @post)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Blog Post removed', flash[:success]
    end
  end
end
