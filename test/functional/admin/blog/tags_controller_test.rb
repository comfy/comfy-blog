require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class Admin::Blog::TagsControllerTest < ActionController::TestCase

  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:tags)
  end

  def test_get_edit
    get :edit, :id => blog_tags(:tag)
    assert_response :success
    assert_template :edit
    assert assigns(:tag)
  end
  
  def test_get_new
    get :new
    assert_response :success
    assert_template :new
    assert assigns(:tag)
  end

  def test_update
    tag = blog_tags(:tag)
    assert_no_difference 'Blog::Tag.count' do
      put :update, :id => tag, :tag => {
        :name => 'Updated'
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      
      tag.reload
      assert_equal 'Updated', tag.name 
    end
  end
  
  def test_update_failure
    tag = blog_tags(:tag)
    assert_no_difference 'Blog::Tag.count' do
      put :update, :id => tag, :tag => {
        :name => 'Duplicate' # Notice case
      }
      assert_response :success
      assert_template :edit
      assert_equal 'Failed to update Blog Tag', flash[:error]
      
      tag.reload
      assert_equal 'tag', tag.name 
    end
  end

  def test_creation
    assert_difference 'Blog::Tag.count' do
      post :create, :tag => {
        :name => 'test'
      }
      assert_response :redirect
      assert_redirected_to :action => :index
      assert assigns(:tag).valid?
      assert_equal 'Blog Tag created', flash[:notice]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Tag.count' do
      post :create, :tag => {
        :name => 'Duplicate'  # Notice case
      }
      assert_response :success
      assert_template :new
      assert assigns(:tag).invalid?
      assert_equal 'Failed to create Blog Tag', flash[:error]
    end
  end
  
  def test_destroy
    assert_difference 'Blog::Tag.count', -1 do
      delete :destroy, :id => blog_tags(:tag)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Blog Tag removed', flash[:notice]
    end
  end
  
end
