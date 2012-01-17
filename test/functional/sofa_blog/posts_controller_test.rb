require File.expand_path('../../test_helper', File.dirname(__FILE__))

class SofaBlog::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:posts)
  end
  
  def test_get_index_with_pagination
    
  end
  
  def test_get_show
    
  end
  
  def test_get_show_invalid
    
  end
  
end
