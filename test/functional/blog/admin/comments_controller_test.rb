require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class SofaBlog::Admin::CommentsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index, :post_id => sofa_blog_posts(:default).id
    assert_response :success
    assert assigns(:post)
    assert assigns(:comments)
    assert_template :index
  end
  
  def test_get_new
    get :new, :post_id => sofa_blog_posts(:default).id
    assert_response :success
    assert assigns(:post)
    assert assigns(:comment)
    assert_template :new
  end
  
  def test_creation
    assert_difference 'SofaBlog::Comment.count' do
      post :create, :post_id => sofa_blog_posts(:default).id, :comment => {:name => 'John Doe', :email => 'john@test.com', :content => 'New comment'}
      assert assigns(:post)
      assert_equal 'Comment created', flash[:notice]
      assert_redirected_to :action => :index
    end
  end
  
  def test_creation_failure
    assert_no_difference 'SofaBlog::Comment.count' do
      post :create, :post_id => sofa_blog_posts(:default).id, :post => {:name => nil, :email => nil, :content => 'New comment'}
      assert_response :success
      assert assigns(:post)
      assert_template :new
    end
  end
  
  def test_get_edit
    get :edit, :post_id => sofa_blog_posts(:default).id, :id => sofa_blog_comments(:default).id
    assert_response :success
    assert assigns(:post)
    assert assigns(:comment)
    assert_template :edit
  end
  
  def test_get_edit_failure_on_bogus_comment
    get :edit, :post_id => sofa_blog_posts(:default).id, :id => 'bogus'
    assert_equal 'Comment not found', flash[:error]
    assert_redirected_to :action => :index
  end
  
  def test_get_edit_failure_on_bogus_post
    get :edit, :post_id => 'bogus', :id => 'bogus'
    assert_equal 'Blog post not found', flash[:error]
    assert_redirected_to sofa_blog_admin_posts_path
  end

end