require_relative '../test_helper'

class BlogTest < ActiveSupport::TestCase

  setup do
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
  end

  def test_site_association
    assert_equal [@blog], @site.blogs
  end

  def test_fixtures_validity
    Comfy::Blog::Blog.all.each do |blog|
      assert blog.valid?, blog.errors.inspect
    end
  end

  def test_validation
    blog = Comfy::Blog::Blog.new
    assert blog.invalid?
    assert_errors_on blog, :site, :label, :identifier
  end

  def test_validation_path_presence
    blog_a = @blog
    refute blog_a.path.present?

    blog_b = @site.blogs.new(
      label:      'Test Blog B',
      identifier: 'test-blog-b'
    )
    assert blog_b.invalid?
    assert_errors_on blog_b, :path

    blog_b.path = 'blog-b'
    assert blog_b.valid?
  end

  def test_creation
    assert_difference -> {Comfy::Blog::Blog.count} do
      @site.blogs.create(
        label:      'Test Blog',
        identifier: 'test-blog',
        path:       'test-blog'
      )
    end
  end

  def test_destroy
    blog_count = -> {Comfy::Blog::Blog.count}
    post_count = -> {Comfy::Blog::Post.count}
    assert_difference [blog_count, post_count], -1 do
      @site.destroy
    end
  end
end
