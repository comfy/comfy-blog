class Admin::Blog::CommentsController < Admin::Cms::BaseController
  
  before_action :load_comment, :only => [:destroy, :toggle_publish]
  
  def index
    @comments = if @post = @site.blog_posts.where(:id => params[:post_id]).first
      @post.comments.page(params[:page])
    else
      @site.blog_comments.page(params[:page])
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
    @comment = @site.blog_comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Comment not found'
    redirect_to :action => :index
  end
  
end