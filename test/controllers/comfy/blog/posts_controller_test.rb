# frozen_string_literal: true

require_relative "../../../test_helper"

class Comfy::Blog::PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @site = comfy_cms_sites(:default)
    @post = comfy_blog_posts(:default)
  end

  def test_get_index
    get comfy_blog_posts_path
    assert_response :success
    assert_template :index
    assert assigns(:blog_posts)
    assert_equal 1, assigns(:blog_posts).size
  end

  def test_get_index_as_rss
    get comfy_blog_posts_path, params: { format: :rss }
    assert_response :success
    assert_template :index
    assert assigns(:blog_posts)
    assert_equal 1, assigns(:blog_posts).size
  end

  def test_get_index_with_unpublished
    comfy_blog_posts(:default).update_column(:is_published, false)
    get comfy_blog_posts_path
    assert_response :success
    assert_equal 0, assigns(:blog_posts).size
  end

  def test_get_index_for_year_archive
    get comfy_blog_posts_of_year_path(@site.path, 2012)
    assert_response :success
    assert_equal 1, assigns(:blog_posts).size

    get comfy_blog_posts_of_year_path(@site.path, 1999)
    assert_response :success
    assert_equal 0, assigns(:blog_posts).size
  end

  def test_get_index_for_month_archive
    get comfy_blog_posts_of_month_path(@site.path, 2012, 1)
    assert_response :success
    assert_equal 1, assigns(:blog_posts).size

    get comfy_blog_posts_of_month_path(@site.path, 2012, 12)
    assert_response :success
    assert_equal 0, assigns(:blog_posts).size
  end

  def test_get_index_with_category
    category = @site.categories.create!(
      label:            "Test Category",
      categorized_type: "Comfy::Blog::Post"
    )
    category.categorizations.create!(categorized: @post)

    get comfy_blog_posts_path, params: { category: category.label }

    assert_response :success
    assert assigns(:blog_posts)
    assert_equal 1, assigns(:blog_posts).count
    assert assigns(:blog_posts).first.categories.member? category
  end

  def test_get_index_with_category_invalid
    get comfy_blog_posts_path, params: { category: "invalid" }
    assert_response :success
    assert assigns(:blog_posts)
    assert_equal 0, assigns(:blog_posts).count
  end

  def test_get_show
    expected_content =
      "<h1>Default Title</h1>\n"\
      "<p>\n"\
      "Published on\n"\
      ":\n"\
      "#{@post.published_at.to_formatted_s(:short)}\n"\
      "</p>\n"\
      "blog post content\n"\

    @post.update_column(:content_cache, "blog post content")
    get comfy_blog_post_path(@site.path, @post.year, @post.month, @post.slug)
    assert_response :success
    assert_equal expected_content, response.body
  end

  def test_get_show_unpublished
    @post.update_attribute(:is_published, false)
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get comfy_blog_post_path(@site.path, @post.year, @post.month, @post.slug)
    end
  end

  def test_get_show_with_date_invalid
    assert_exception_raised ComfortableMexicanSofa::MissingPage do
      get comfy_blog_post_path(@site.path, 1234, 99, @post.slug)
    end
  end

end
