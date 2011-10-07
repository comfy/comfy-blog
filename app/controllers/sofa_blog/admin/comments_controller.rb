class SofaBlog::Admin::CommentsController < SofaBlog::Admin::BaseController
  
  before_filter :load_post
  before_filter :load_comment,        :only => [:show, :edit, :update, :destroy, :approve, :disapprove]
  before_filter :build_comment,  :only => [:new, :create]
  
  def index
    @comments = SofaBlog::Comment.order('created_at DESC')
  end
  
  def show
    render
  end
  
  def new
    render
  end
  
  def create
    @comment.save!
    flash[:notice] = 'Comment created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Comment'
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @comment.update_attributes(params[:comment])
    flash[:notice] = 'Comment updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Comment'
    render :action => :edit
  end
  
  def destroy
    @comment.destroy
    flash[:notice] = 'Comment removed'
    redirect_to :action => :index
  end
  
  def approve
    @comment.approve!
  end
  
  def disapprove
    @comment.disapprove!
  end
  
protected
  
  def load_post
    @post = SofaBlog::Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog post not found'
    redirect_to sofa_blog_admin_posts_path
  end

  def load_comment
    @comment = SofaBlog::Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Comment not found'
    redirect_to :action => :index
  end
  
  def build_comment
    @comment = @post.comments.build(params[:comment])
  end
end