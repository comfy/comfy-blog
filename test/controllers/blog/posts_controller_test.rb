require_relative '../../test_helper'

class Blog::PostsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_as_rss
    get :index, :format => :rss
    assert_response :success
    assert_template :index
    assert assigns(:posts)
    assert_equal 1, assigns(:posts).size
  end
  
  def test_get_index_with_unpublished
    blog_posts(:default).update_column(:is_published, false)
    get :index
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_year_archive
    get :index, :year => 2012
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, :year => 1999
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_month_archive
    get :index, :year => 2012, :month => 1
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, :year => 2012, :month => 12
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_show
    get :show, :id => blog_posts(:default)
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_unpublished
    post = blog_posts(:default)
    post.update_attribute(:is_published, false)
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :show, :id => post
    end
  end
  
  def test_get_show_with_date
    post = blog_posts(:default)
    get :show, :year => post.year, :month => post.month, :slug => blog_posts(:default).slug
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_with_date_invalid
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :show, :year => '1999', :month => '99', :slug => 'invalid'
    end
  end
  
  def test_get_show_with_disqus
    ComfyBlog.config.disqus_shortname = 'test'
    post = blog_posts(:default)
    get :show, :year => post.year, :month => post.month, :slug => blog_posts(:default).slug
    assert_response :success
  end
  
end
