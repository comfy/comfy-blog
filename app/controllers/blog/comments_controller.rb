class Blog::CommentsController < Cms::BaseController
  
  def create
    @post = Blog::Post.published.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.save!

    respond_to do |f|
      f.html do 
        flash[:success] = 'Comment created'
          redirect_to blog_posts_dated_path(
            :year   => @post.year,
            :month  => @post.month,
            :slug   => @post.slug
          )
        end
      f.js
    end

  rescue ActiveRecord::RecordNotFound
    respond_to do |f|
      f.html do
        flash[:error] = 'Blog Post not found'
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

protected

  def comment_params
    params.fetch(:comment, {}).permit(:author, :email, :content)
  end
end