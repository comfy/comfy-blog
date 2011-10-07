require File.expand_path('../test_helper', File.dirname(__FILE__))

class SofaBlog::PostTest < ActiveSupport::TestCase
  
  def test_fixtures_validity
    SofaBlog::Post.all.each do |post|
      assert post.valid?, post.errors.full_messages.to_s
    end
  end
  
  def test_validations
    post = SofaBlog::Post.new
    assert post.invalid?
    assert_has_errors_on post, [:title, :content]
  end
  
  def test_creation
    assert_difference 'SofaBlog::Post.count' do
      SofaBlog::Post.create!(
        :title    => 'Test Post',
        :content  => 'Test Content'
      )
    end
  end
  
  def test_destroy
    assert_difference ['SofaBlog::Post.count', 'SofaBlog::Comment.count'], -1 do
      sofa_blog_posts(:default).destroy
    end
  end
  
  def test_to_param
    post = sofa_blog_posts(:default)
    assert_equal "#{post.id}-default-title", post.to_param
  end
  
  def test_scope_published
    post = sofa_blog_posts(:default)
    assert post.is_published?
    assert_equal 1, SofaBlog::Post.published.count
    assert_equal post, SofaBlog::Post.published.first
  end
  
end
