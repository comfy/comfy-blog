require_relative '../../../test_helper'

class Comfy::Blog::CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @blog = comfy_blog_blogs(:default)
    @post = comfy_blog_posts(:default)
  end

  def test_get_index
    get :index
    
    assert_response :success

    assert_select 'li a', count: 1
  end
  
  def test_show
    get :show, params: { slug: 'default' }

    assert_response :success
    assert_select 'li a', 1
  end
  
  def test_show_invalid
    assert_raises 'ActiveRecord::RecordNotFound' do
      get :show, params: { slug: 'invalid' }
    end
  end

end