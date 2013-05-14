class Admin::Blog::CommentsController < Admin::Blog::BaseController
  
  before_filter :load_post,     :only => [:index]
  before_filter :load_comment,  :only => [:destroy, :publish]
  
  def index
    @comments = @post ? @post.comments : Blog::Comment.all
  end
  
  def destroy
    @comment.destroy
  end
  
  def publish
    @comment.update_attribute(:is_published, true)
  end
  
protected
  
  def load_post
    return unless params[:post_id]
    @post = Blog::Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = I18n.t('comfy_blog.post_not_found')
    redirect_to :action => :index
  end
  
  def load_comment
    @comment = Blog::Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # ... do nothing
  end
  
end