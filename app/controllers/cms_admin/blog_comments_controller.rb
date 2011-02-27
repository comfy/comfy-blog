class CmsAdmin::BlogCommentsController < CmsAdmin::BaseController
  before_filter :load_blog_post
  before_filter :build_blog_comment, :only => [:new, :create]
  before_filter :load_blog_comment, :only => [:show, :edit, :update, :destroy, :approve, :disapprove]

  def index
    @blog_comments = BlogComment.order('created_at DESC')
  end

  def show
    # ...
  end

  def new
    # ...
  end

  def create
    @blog_comment.save!
    flash[:notice] = 'Comment created'
    redirect_to :action => :edit, :id => @blog_post
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def edit
    # ...
  end

  def update
    if @blog_comment.update_attributes(params[:blog_comment])
      flash[:notice] = 'Comment updated'
      redirect_to :action => :index, :id => @blog_comment
    else
      render :action => :edit
    end
  end

  def destroy
    @blog_comment.destroy

    flash[:notice] = 'Comment removed'
    redirect_to :action => :index
  end

  def approve
    @blog_comment.approve!
  end

  def disapprove
    @blog_comment.disapprove!
  end

protected
  def load_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def load_blog_comment
    @blog_comment = BlogComment.find(params[:id])
  end
  
  def build_blog_comment
    @blog_comment = @blog_post.blog_comments.build(params[:blog_comment])
  end
end