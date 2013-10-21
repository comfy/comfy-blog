require_relative '../../test_helper'

class Blog::CommentsControllerTest < ActionController::TestCase
  
  def setup
    @blog = blog_blogs(:default)
    @post = blog_posts(:default)
  end

  def test_creation
    assert_difference 'Blog::Comment.count' do
      post :create, :slug => @post.slug, :comment => {
        :author   => 'Test',
        :email    => 'test@test.test',
        :content  => 'Test Content'
      }
      assert_response :redirect
      assert_redirected_to blog_post_path
      assert_equal 'Comment created', flash[:success]
      
      comment = Blog::Comment.last
      assert_equal 'Test', comment.author
      assert_equal @post, comment.post
    end
  end
  
  def test_creation_failure
    assert_no_difference 'Blog::Comment.count' do
      post :create, :slug => @post.slug, :comment => { }
      assert_response :success
      assert_template :show
      assert_equal 'Failed to create Comment', flash[:error]
    end
  end

end