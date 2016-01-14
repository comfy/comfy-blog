require_relative '../../../../test_helper'

class Comfy::Admin::Blog::PostsControllerTest < ActionController::TestCase

  def setup
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
    @post = comfy_blog_posts(:default)
  end

  def test_get_index
    get :index, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:posts)
    assert_template :index
  end

  def test_get_index_with_category
    category = @site.categories.create!(:label => 'Test Category', :categorized_type => 'Comfy::Blog::Post')
    category.categorizations.create!(:categorized => @post)

    get :index, :site_id => @site, :blog_id => @blog, :category => category.label
    assert_response :success
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).count
    assert assigns(:posts).first.categories.member? category
  end

  def test_get_index_with_category_invalid
    get :index, :site_id => @site, :blog_id => @blog, :category => 'invalid'
    assert_response :success
    assert assigns(:posts)
    assert_equal 0, assigns(:posts).count
  end

  def test_get_new
    get :new, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:post)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/posts']"
  end

  def test_get_new_with_default_author
    ComfyBlog.config.default_author = 'Default Author'
    get :new, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:post)
    assert_equal 'Default Author', assigns(:post).author
  end

  def test_creation
    assert_difference 'Comfy::Blog::Post.count' do
      post :create, :site_id => @site, :blog_id => @blog, :post => {
        :title        => 'Test Post',
        :slug         => 'test-post',
        :content      => 'Test Content',
        :excerpt      => 'Test Excerpt',
        :published_at => 2.days.ago.to_s(:db),
        :is_published => '1'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => assigns(:post)
      assert_equal 'Blog Post created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Comfy::Blog::Post.count' do
      post :create, :site_id => @site, :blog_id => @blog, :post => { }
      assert_response :success
      assert_template :new
      assert assigns(:post)
      assert_equal 'Failed to create Blog Post', flash[:error]
    end
  end

  def test_get_edit
    get :edit, :site_id => @site, :blog_id => @blog, :id => @post
    assert_response :success
    assert_template :edit
    assert assigns(:post)
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/posts/#{@post.id}']"
  end

  def test_get_edit_failure
    get :edit, :site_id => @site, :blog_id => @blog, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Blog Post not found', flash[:error]
  end

  def test_update
    put :update, :site_id => @site, :blog_id => @blog, :id => @post, :post => {
      :title => 'Updated Post'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => assigns(:post)
    assert_equal 'Blog Post updated', flash[:success]

    @post.reload
    assert_equal 'Updated Post', @post.title
  end

  def test_update_failure
    put :update, :site_id => @site, :blog_id => @blog, :id => @post, :post => {
      :title => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Blog Post', flash[:error]

    @post.reload
    assert_not_equal '', @post.title
  end

  def test_destroy
    assert_difference 'Comfy::Blog::Post.count', -1 do
      delete :destroy, :site_id => @site, :blog_id => @blog, :id => @post
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Blog Post removed', flash[:success]
    end
  end

end
