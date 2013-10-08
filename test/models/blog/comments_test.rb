require_relative '../../test_helper'

class BlogCommentsTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    Blog::Comment.all.each do |comment|
      assert comment.valid?, comment.errors.full_messages.to_s
    end
  end
  
  def test_validations
    comment = Blog::Comment.new
    assert comment.invalid?
    assert_errors_on comment, [:post_id, :content, :author, :email]
  end
  
  def test_creation
    assert_difference 'Blog::Comment.count' do
      comment = blog_posts(:default).comments.create(
        :content  => 'Test Content',
        :author   => 'Tester',
        :email    => 'test@test.test'
      )
      assert !comment.is_published?
    end
  end
  
  def test_creation_with_auto_publishing
    ComfyBlog.config.auto_publish_comments = true
    
    comment = blog_posts(:default).comments.create(
      :content  => 'Test Content',
      :author   => 'Tester',
      :email    => 'test@test.test'
    )
    assert comment.is_published?
  end
  
  def test_scope_published
    assert_equal 1, Blog::Comment.published.count
    
    blog_comments(:default).update_attribute(:is_published, false)
    assert_equal 0, Blog::Comment.published.count
  end
  
end