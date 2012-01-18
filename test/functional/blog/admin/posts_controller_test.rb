require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Blog::Admin::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:posts)
    assert_template :index
  end
  
  def test_get_new
    get :new
    assert_response :success
    assert assigns(:post)
    assert_template :new
    assert_select "form[action='/admin/posts']"
  end
  
  def test_creation
    assert_difference 'SofaBlog::Post.count' do
      post :create, :post => {:title => 'New post', :content => 'Lost of words'}
      assert assigns(:post)
      assert_equal 'Blog post created', flash[:notice]
      assert_redirected_to :action => :index
    end
  end
  
  def test_creation_failure
    assert_no_difference 'SofaBlog::Post.count' do
      post :create, :post => {:title => nil, :content => 'Lost of words'}
      assert_response :success
      assert assigns(:post)
      assert_template :new
    end
  end
  
  def test_get_edit
    get :edit, :id => sofa_blog_posts(:default)
    assert_response :success
    assert_template :edit
  end
  
  def test_get_edit_failure
    get :edit, :id => 'bogus'
    assert_equal 'Blog post not found', flash[:error]
    assert_redirected_to :action => :index
  end
  
  def test_update
    assert_not_equal 'New post', sofa_blog_posts(:default).title
    assert_not_equal 'Lost of words', sofa_blog_posts(:default).content
    put :update, :id => sofa_blog_posts(:default).id, :post => {:title => 'New post', :content => 'Lost of words'}
    assert assigns(:post)
    assert_redirected_to :action => :index
    assert_equal 'Blog post updated', flash[:notice]
    assert_equal 'New post', assigns(:post).title
    assert_equal 'Lost of words', assigns(:post).content
  end
  
  def test_update_failure
    put :update, :id => 'bogus', :post => {:title => 'New post', :content => 'Lost of words'}
    assert_equal 'Blog post not found', flash[:error]
    assert_redirected_to :action => :index
  end
  
  def test_destroy
    assert_difference 'SofaBlog::Post.count', -1 do
      delete :destroy, :id => sofa_blog_posts(:default).id
      assert assigns(:post)
      assert_equal 'Blog post removed', flash[:notice]
      assert_redirected_to :action => :index
    end
  end
  
end