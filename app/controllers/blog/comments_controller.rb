class Blog::CommentsController < ApplicationController
  
  def create
    @post = Blog::Post.published.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    @comment.save!
    
    respond_to do |f|
      f.html do
        flash[:notice] = I18n.t('comfy_blog.comment_created')
        redirect_to dated_blog_post_path(@post.year, @post.month, @post.slug)
      end
      f.js
    end
    
  rescue ActiveRecord::RecordNotFound
    respond_to do |f|
      f.html do
        flash[:error] = I18n.t('comfy_blog.post_not_found')
        redirect_to blog_posts_path
      end
      f.js do
        render :nothing => true, :status => 404
      end
    end
    
  rescue ActiveRecord::RecordInvalid
    respond_to do |f|
      f.html do
        render 'blog/posts/show'
      end
      f.js
    end
  end
end