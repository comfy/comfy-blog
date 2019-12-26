# frozen_string_literal: true

require_relative "../test_helper"

class BlogPostsTest < ActiveSupport::TestCase

  setup do
    @site   = comfy_cms_sites(:default)
    @layout = comfy_cms_layouts(:default)
    @post   = comfy_blog_posts(:default)
  end

  def test_fixtures_validity
    Comfy::Blog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end

  def test_validations
    post = Comfy::Blog::Post.new
    assert post.invalid?
    assert_errors_on post, :site, :title, :slug, :layout
  end

  def test_validation_of_slug_uniqueness
    @post.update!(published_at: Time.now)
    post = @site.blog_posts.new(
      title:  @post.title,
      layout: @layout
    )
    assert post.invalid?
    assert_errors_on post, [:slug]

    @post.update!(published_at: 1.year.ago)
    assert post.valid?
  end

  def test_validation_of_slug_format
    post = @site.blog_posts.new(
      title: "Test Title",
      slug:  "test%slug",
      layout: @layout
    )
    assert post.valid?
  end

  def test_creation
    assert_difference -> { Comfy::Blog::Post.count } do
      post = @site.blog_posts.create!(
        title: "Test Post",
        layout: @layout
      )
      assert_equal "test-post",           post.slug
      assert_equal Time.zone.now.year,    post.year
      assert_equal Time.zone.now.month,   post.month
    end
  end

  def test_set_slug
    post = Comfy::Blog::Post.new(title: "Test Title")
    post.send(:set_slug)
    assert_equal "test-title", post.slug
  end

  def test_set_date
    post = Comfy::Blog::Post.new
    post.send(:set_published_at)
    post.send(:set_date)
    assert_equal post.published_at.year,  post.year
    assert_equal post.published_at.month, post.month
  end

  def test_set_published_at
    post = Comfy::Blog::Post.new
    post.send(:set_published_at)
    assert post.published_at.present?
  end

  def test_scope_published
    assert @post.is_published?
    assert_equal 1, Comfy::Blog::Post.published.count

    @post.update_attribute(:is_published, false)
    assert_equal 0, Comfy::Blog::Post.published.count
  end

  def test_scope_for_year
    assert_equal 1, Comfy::Blog::Post.for_year(2012).count
    assert_equal 0, Comfy::Blog::Post.for_year(2013).count
  end

  def test_scope_for_month
    assert_equal 1, Comfy::Blog::Post.for_month(1).count
    assert_equal 0, Comfy::Blog::Post.for_month(2).count
  end

  def test_url
    assert_equal "//test.host/blog/2012/1/default-title", @post.url
    assert_equal "/blog/2012/1/default-title", @post.url(relative: true)

    ComfyBlog.config.public_blog_path = "test-blog"
    assert_equal "//test.host/test-blog/2012/1/default-title", @post.url
  end

end
