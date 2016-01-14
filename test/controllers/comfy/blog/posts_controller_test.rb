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

  def test_get_index_for_category
    category = comfy_cms_sites(:default).categories.create!(:label => 'Test Category', :categorized_type => 'Comfy::Blog::Post')
    category.categorizations.create!(:categorized => @post)

    get :serve, :category => 'Test Category'
    assert_response :success
    assert_template :index
    assert_equal 1, assigns(:posts).size

    get :serve, :category => 'invalid'
    assert_response :success
    assert_template :index
    assert_equal 0, assigns(:posts).size
  end

  def test_get_show
    get :serve, :slug => @post.slug
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end

  def test_get_show_unpublished
    @post.update_attribute(:is_published, false)
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :serve, :slug => @post.slug
    end
  end

  def test_get_show_with_date
    get :show, :year => @post.year, :month => @post.month, :slug => @post.slug
    assert_response :success
    assert_template :show
    assert assigns(:post)
  end

  def test_get_show_with_date_invalid
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get :show, :year => '1999', :month => '99', :slug => 'invalid'
    end
  end

end
