require_relative '../test_helper'

class BlogPostsTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Comfy::Blog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end

  def test_validations
    post = Comfy::Blog::Post.new
    assert post.invalid?
    assert_errors_on post, :blog_id, :title, :slug, :content
  end

  def test_validation_of_slug_uniqueness
    old_post = comfy_blog_posts(:default)
    old_post.update_attributes!(:published_at => Time.now)
    post = comfy_blog_blogs(:default).posts.new(
      :title    => old_post.title,
      :content  => 'Test Content'
    )
    assert post.invalid?
    assert_errors_on post, [:slug]

    old_post.update_attributes!(:published_at => 1.year.ago)
    assert post.valid?
  end

  def test_validation_of_slug_format
    post = comfy_blog_blogs(:default).posts.new(
      :title    => 'Test Title',
      :slug     => 'test%slug',
      :content  => 'Test Content'
    )
    assert post.valid?
  end

  def test_creation
    assert_difference 'Comfy::Blog::Post.count' do
      post = comfy_blog_blogs(:default).posts.create!(
        :title    => 'Test Post',
        :content  => 'Test Content'
      )
      assert_equal 'test-post', post.slug
      assert_equal Time.now.year, post.year
      assert_equal Time.now.month, post.month
    end
  end

  def test_set_slug
    post = Comfy::Blog::Post.new(:title => 'Test Title')
    post.send(:set_slug)
    assert_equal 'test-title', post.slug
  end

  def test_set_date
    post = Comfy::Blog::Post.new
    post.send(:set_published_at)
    post.send(:set_date)
    assert_equal post.published_at.year, post.year
    assert_equal post.published_at.month, post.month
  end

  def test_set_published_at
    post = Comfy::Blog::Post.new
    post.send(:set_published_at)
    assert post.published_at.present?
  end

  def test_destroy
    assert_difference ['Comfy::Blog::Post.count', 'Comfy::Blog::Comment.count'], -1 do
      comfy_blog_posts(:default).destroy
    end
  end

  def test_scope_published
    post = comfy_blog_posts(:default)
    assert post.is_published?
    assert_equal 1, Comfy::Blog::Post.published.count

    post.update_attribute(:is_published, false)
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

  def test_scope_for_tag
    post = comfy_blog_posts(:default)
    post.tags.create!(
      :name => 'Linky Tag!'
    )
    assert_equal 1, Comfy::Blog::Post.for_tag('Linky Tag!').count
    assert_equal 0, Comfy::Blog::Post.for_tag('Not a tag').count
  end

  def test_tag_list
    post = comfy_blog_posts(:default)
    post.tags.create!(
        :name => 'Tag 1!'
      )
    assert_equal 'Tag 1!', post.tag_list
  end

  def test_tag_list_create
    post = comfy_blog_posts(:default)
    assert_difference 'Comfy::Blog::Tag.count', +2 do
      post.tag_list=('Posted Tag!, Twice!')
    end
  end
end
