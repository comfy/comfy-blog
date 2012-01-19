require File.expand_path('../../test_helper', File.dirname(__FILE__))

class Blog::CommentsControllerTest < ActionController::TestCase

  def test_creation
    p = blog_posts(:default)
    
    assert_difference 'Blog::Comment.count' do
      post :create, :post_id => p, :comment => {
        :author   => 'Test',
        :email    => 'test@test.test',
        :content  => 'Test Content'
      }
      assert_response :redirect
      assert_redirected_to dated_blog_post_path(p.year, p.month, p.slug)
      assert_equal 'Comment created', flash[:notice]
      
      comment = Blog::Comment.last
      assert_equal 'Test', comment.author
      assert_equal p, comment.post
    end
  end
  
  def test_creation_failure
    p = blog_posts(:default)
    
    assert_no_difference 'Blog::Comment.count' do
      post :create, :post_id => p, :comment => { }
      assert_response :success
      assert_template :show
    end
  end
  
  def test_creation_failure_invalid_post
    assert_no_difference 'Blog::Comment.count' do
      post :create, :post_id => 'invalid', :comment => { }
      assert_response :redirect
      assert_redirected_to blog_posts_path
      assert_equal 'Blog Post not found', flash[:error]
    end
  end
  
  def test_creation_xhr
    p = blog_posts(:default)
    
    assert_difference 'Blog::Comment.count' do
      xhr :post, :create, :post_id => p, :comment => {
        :author   => 'Test',
        :email    => 'test@test.test',
        :content  => 'Test Content'
      }
      assert_response :success
      assert_template :create
      
      comment = Blog::Comment.last
      assert_equal 'Test', comment.author
      assert_equal p, comment.post
    end
  end
  
  def test_creation_xhr_failure
    p = blog_posts(:default)
    
    assert_no_difference 'Blog::Comment.count' do
      xhr :post, :create, :post_id => p, :comment => { }
      assert_response :success
      assert_template :create
    end
  end
  
  def test_creation_xhr_failure_invalid_post
    assert_no_difference 'Blog::Comment.count' do
      xhr :post, :create, :post_id => 'invalid', :comment => { }
      assert_response 404
    end
  end

end