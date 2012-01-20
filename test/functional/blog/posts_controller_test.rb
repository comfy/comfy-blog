require File.expand_path('../../test_helper', File.dirname(__FILE__))

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
    blog_posts(:default).update_attribute(:is_published, false)
    get :index
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_with_pagination
    get :index, :page => 99
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_tagged
    get :index, :tag => blog_tags(:tag).name
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, :tag => 'invalid'
    assert_response :success
    assert_equal 0, assigns(:posts).size
  end
  
  def test_get_index_for_categorized
    get :index, :category => blog_tags(:category).name
    assert_response :success
    assert_equal 1, assigns(:posts).size
    
    get :index, :category => 'invalid'
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
    get :show, :id => post
    assert_response 404
  end
  
  def test_get_show_with_date
    post = blog_posts(:default)
    get :show, :year => post.year, :month => post.month, :slug => blog_posts(:default).slug
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end
  
  def test_get_show_with_date_invalid
    get :show, :year => '1999', :month => '99', :slug => 'invalid'
    assert_response 404
  end
  
end
