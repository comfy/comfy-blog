class Comfy::Admin::Blog::CommentsController < Comfy::Admin::Blog::BaseController
  
  before_action :load_blog
  before_action :load_comment, :only => [:destroy, :toggle_publish]
  
  def index
    @comments = if @post = @blog.posts.where(:id => params[:post_id]).first
      @post.comments.page(params[:page])
    else
      @blog.comments.page(params[:page])
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to :action => :index
  end
  
  def toggle_publish
    @comment.update_attribute(:is_published, !@comment.is_published?)
  end

protected
  
  def load_comment
    @comment = @blog.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Comment not found'
    redirect_to :action => :index
  end
  
end