class Blog::CommentsController < ApplicationController
  
  def create
    @post = Blog::Post.published.find(params[:post_id])
    @comment = @post.comments.create!(params[:comment])
    
    respond_with do |f|
      f.html do 
        
      end
      f.js
    end
    
  rescue ActiveRecord::RecordNotFound
    respond_with do |f|
      f.html do
        redirect_to blog_posts_path
        f[:error] = 'Blog Post not found'
      end
      f.js do
        render :nothing => true, :status => 404
      end
    end
  rescue ActiveRecord::RecordInvalid
    
  end
  
end