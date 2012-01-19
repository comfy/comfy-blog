class Admin::Blog::PostsController < Admin::Blog::BaseController
  
  before_filter :build_post, :only => [:new, :create]
  before_filter :load_post,  :only => [:edit, :update, :destroy]
  
  def index
    @posts = Blog::Post.paginate :page => params[:page]
  end
  
  def new
    render
  end
  
  def create
    @post.save!
    flash.now[:notice] = 'Blog Post created'
    redirect_to :action => :edit, :id => @post
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Blog Post'
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @post.update_attributes!(params[:post])
    flash.now[:notice] = 'Blog Post updated'
    render :action => :edit
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Blog Post'
    render :action => :edit
  end
  
  def destroy
    @post.destroy
    flash[:notice] = 'Blog Post removed'
    redirect_to :action => :index
  end
  
protected
  
  def load_post
    @post = Blog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog Post not found'
    redirect_to :action => :index
  end
  
  def build_post
    @post = Blog::Post.new(params[:post])
  end
  
end