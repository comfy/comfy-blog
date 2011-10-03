require File.expand_path('../../../test_helper', File.dirname(__FILE__))

class SofaBlog::Admin::PostsControllerTest < ActionController::TestCase
  
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
  
  def test_get_edit
    get :edit, :id => sofa_blog_posts(:default)
    assert_response :success
  end
  
  def test_get_edit_failure
    flunk
  end
  
  def test_creation
    flunk
  end
  
  def test_creation_failure
    flunk
  end
  
  def test_update
    flunk
  end
  
  def test_update_failure
    flunk
  end
  
  def test_destroy
    flunk
  end
  
end