require_relative '../../test_helper'

class BlogPostsTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end
  
  def test_validations
    post = Blog::Post.new
    assert post.invalid?
    assert_errors_on post, :blog_id, :title, :slug, :content
  end
  
  def test_validation_of_slug_uniqueness
    old_post = blog_posts(:default)
    old_post.update_attributes!(:published_at => Time.now)
    post = blog_blogs(:default).posts.new(
      :title    => old_post.title,
      :content  => 'Test Content'
    )
    assert post.invalid?
    assert_errors_on post, [:slug]

    old_post.update_attributes!(:published_at => 1.year.ago)
    assert post.valid?
  end
  
  def test_creation
    assert_difference 'Blog::Post.count' do
      post = blog_blogs(:default).posts.create!(
        :title    => 'Test Post',
        :content  => 'Test Content'
      )
      assert_equal 'test-post', post.slug
      assert_equal Time.now.year, post.year
      assert_equal Time.now.month, post.month
    end
  end
  
  def test_set_slug
    post = Blog::Post.new(:title => 'Test Title')
    post.send(:set_slug)
    assert_equal 'test-title', post.slug
  end
  
  def test_set_date
    post = Blog::Post.new
    post.send(:set_published_at)
    post.send(:set_date)
    assert_equal post.published_at.year, post.year
    assert_equal post.published_at.month, post.month
  end
  
  def test_set_published_at
    post = Blog::Post.new
    post.send(:set_published_at)
    assert post.published_at.present?
  end
  
  def test_destroy
    assert_difference ['Blog::Post.count', 'Blog::Comment.count'], -1 do
      blog_posts(:default).destroy
    end
  end

  def test_scope_published
    post = blog_posts(:default)
    assert post.is_published?
    assert_equal 1, Blog::Post.published.count

    post.update_attribute(:is_published, false)
    assert_equal 0, Blog::Post.published.count
  end

  def test_scope_for_year
    assert_equal 1, Blog::Post.for_year(2012).count
    assert_equal 0, Blog::Post.for_year(2013).count
  end

  def test_scope_for_month
    assert_equal 1, Blog::Post.for_month(1).count
    assert_equal 0, Blog::Post.for_month(2).count
  end
  
end