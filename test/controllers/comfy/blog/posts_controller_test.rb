require_relative '../../../test_helper'

class Comfy::Blog::PostsControllerTest < ActionController::TestCase
  
  def setup
    @blog = comfy_blog_blogs(:default)
    @post = comfy_blog_posts(:default)
  end
  
  def test_get_index
    get :serve
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_as_rss
    get :serve, :format => :rss
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_with_unpublished
    comfy_blog_posts(:default).update_column(:is_published, false)
    get :serve
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_year_archive
    get :index, params: { :year => 2012 }
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, params: { :year => 1999 }
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_month_archive
    get :index, params: { :year => 2012, :month => 1 }
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, params: { :year => 2012, :month => 12 }
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_show
    get :serve, params: { :slug => @post.slug }
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_unpublished
    @post.update_attribute(:is_published, false)
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :serve, params: { :slug => @post.slug }
    end
  end
  
  def test_get_show_with_date
    get :show, params: { :year => @post.year, :month => @post.month, :slug => @post.slug }
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_with_date_invalid
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :show, params: { :year => '1999', :month => '99', :slug => 'invalid' }
    end
  end
  
end
