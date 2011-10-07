require File.expand_path('../test_helper', File.dirname(__FILE__))

class SofaBlog::CommentTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    SofaBlog::Comment.all.each do |comment|
      assert comment.valid?, comment.errors.full_messages.to_yaml
    end
  end
  
  def test_validations
    comment = SofaBlog::Comment.new
    assert comment.invalid?
    assert_has_errors_on comment, [:post_id, :content, :name, :email]
  end
  
  def test_creation
    assert_difference 'SofaBlog::Comment.count' do
      sofa_blog_posts(:default).comments.create!(
        :content  => 'Test Content',
        :name     => 'Tester',
        :email    => 'tester@test.test'
      )
    end
  end
  
  def test_scope_approved
    comment = sofa_blog_comments(:default)
    assert comment.is_approved?
    assert_equal 1, SofaBlog::Comment.approved.count
    assert_equal comment, SofaBlog::Comment.approved.first
  end
  
  def test_approve_and_disapprove!
    comment = sofa_blog_comments(:default)
    post    = comment.post
    
    assert comment.is_approved?
    assert_equal 1, post.comments_count
    assert_equal 1, post.approved_comments_count
    
    comment.disapprove!
    assert !comment.is_approved?
    post.reload
    assert_equal 1, post.comments_count
    assert_equal 0, post.approved_comments_count
    
    comment.approve!
    assert comment.is_approved?
    post.reload
    assert_equal 1, post.comments_count
    assert_equal 1, post.approved_comments_count
  end
  
end
