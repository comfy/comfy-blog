class SofaBlog::Admin::PostsController < SofaBlog::Admin::BaseController
  
  before_filter :build_post, :only => [:new, :create]
  before_filter :load_post,  :only => [:edit, :update, :destroy]
  
  def index
    @posts = SofaBlog::Post.order('created_at DESC')
  end
  
  def new
    @post.is_published ||= true
  end
  
  def edit
    render
  end
  
  def create
    @post.save!
    flash[:notice] = 'BlogPost created'
    redirect_to :action => :edit, :id => @post
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create BlogPost'
    render :action => :new
  end
  
  def update
    @post.update_attributes!(params[:post])
    flash[:notice] = 'BlogPost updated'
    redirect_to :action => :edit, :id => @post
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update BlogPost'
    render :action => :edit
  end
  
  def destroy
    @blog_post.destroy
    flash[:notice] = 'BlogPost removed'
    redirect_to :action => :index
  end
  
protected
  
  def load_post
    @post = SofaBlog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'BlogPost not found'
    redirect_to :action => :index
  end
  
  def build_post
    @post = SofaBlog::Post.new(params[:post])
  end
  
end