require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Admin::Blog::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:posts)
    assert_template :index
  end
  
  def test_get_index_with_pagination
    get :index, :page => 99
    assert_response :success
    assert assigns(:posts)
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_new
    get :new
    assert_response :success
    assert assigns(:post)
    assert_template :new
    assert_select "form[action='/admin/blog/posts']"
  end
  
  def test_creation
    assert_difference 'Blog::Post.count' do
      post :create, :post => {
        :title    => 'Test',
        :content  => 'Content'
      }
      assert_response :success
      assert_template :new
      assert assigns(:post)
      assert_equal 'Blog Post created', flash[:notice]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Post.count' do
      post :create, :post => { }
      assert_response :success
      assert_template :new
      assert assigns(:post)
      assert_equal 'Failed to create Blog Post', flash[:error]
    end
  end
  
  def test_get_edit
    get :edit, :id => blog_posts(:default)
    assert_response :success
    assert_template :edit
    assert assigns(:post)
  end
  
  def test_get_edit_failure
    get :edit, :id => 'bogus'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Blog Post not found', flash[:error]
  end
  
  def test_update
    post = blog_posts(:default)
    put :update, :id => post, :post => {
      :title => 'Updated Post'
    }
    assert_response :success
    assert_template :edit
    assert assigns(:post)
    assert_equal 'Blog Post updated', flash[:notice]
    
    post.reload
    assert_equal 'Updated Post', post.title
  end
  
  def test_update_failure
    post = blog_posts(:default)
    put :update, :id => post, :post => {
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
      delete :destroy, :id => blog_posts(:default)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Blog Post removed', flash[:notice]
    end
  end
  
end