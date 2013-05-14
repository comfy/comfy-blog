class Admin::Blog::PostsController < Admin::Blog::BaseController
  
  before_filter :build_post, :only => [:new, :create]
  before_filter :load_post,  :only => [:edit, :update, :destroy]
  
  def index
    @posts = if defined? WillPaginate
      Blog::Post.paginate :page => params[:page]
    elsif defined? Kaminari
      Blog::Post.page params[:page]
    else
      Blog::Post.all
    end
  end
  
  def new
    render
  end
  
  def create
    @post.save!
    flash[:notice] = I18n.t('comfy_blog.post_created')
    redirect_to :action => :edit, :id => @post
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = I18n.t('comfy_blog.post_create_failed')
    render :action => :new
  end
  
  def edit
    render
  end
  
  def update
    @post.update_attributes!(params[:post])
    flash[:notice] = I18n.t('comfy_blog.post_updated')
    redirect_to :action => :edit, :id => @post
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = I18n.t('comfy_blog.post_update_failed')
    render :action => :edit
  end
  
  def destroy
    @post.destroy
    flash[:notice] = I18n.t('comfy_blog.post_removed')
    redirect_to :action => :index
  end
  
protected
  
  def load_post
    @post = Blog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = I18n.t('comfy_blog.post_not_found')
    redirect_to :action => :index
  end
  
  def build_post
    @post = Blog::Post.new(params[:post])
  end
  
end