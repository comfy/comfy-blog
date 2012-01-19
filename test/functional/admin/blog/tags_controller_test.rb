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
  
  def test_get_create
    get :create
    assert_response :success
    assert_template :create
    assert assigns(:tag)
  end

  def test_creation
    assert_difference 'Blog::Tag.count' do
      post :create, :tag => {
        :name => 'test'
      }
      assert_response :success
      assert_template :new
      assert assigns(:tag).valid?
      assert_equals 'Blog Tag created', flash[:notice]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Tag.count' do
      post :create, :tag => {
        :name => 'tag'
      }
      assert_response :success
      assert_template :new
      assert assigns(:tag).invalid?
      assert_equals 'Failed to create Blog Tag', flash[:notice]
    end
  end
  
end
