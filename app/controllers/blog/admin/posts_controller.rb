class Blog::Admin::PostsController < Blog::Admin::BaseController
  
  before_filter :build_post, :only => [:new, :create]
  before_filter :load_post,  :only => [:edit, :update, :destroy]
  
  def index
    @posts = SofaBlog::Post.order('created_at DESC')
  end
  
  def new
    @post.is_published ||= true
  end
  
  def create
    @post.save!
    flash[:notice] = 'Blog post created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create BlogPost'
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @post.update_attributes!(params[:post])
    flash[:notice] = 'Blog post updated'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update BlogPost'
    render :action => :edit
  end
  
  def destroy
    @post.destroy
    flash[:notice] = 'Blog post removed'
    redirect_to :action => :index
  end
  
protected
  
  def load_post
    @post = SofaBlog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog post not found'
    redirect_to :action => :index
  end
  
  def build_post
    @post = SofaBlog::Post.new(params[:post])
  end
  
end