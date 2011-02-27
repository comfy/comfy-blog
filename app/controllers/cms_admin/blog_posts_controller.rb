class CmsAdmin::BlogPostsController < CmsAdmin::BaseController
  before_filter :build_blog_post, :only => [:new, :create]
  before_filter :load_blog_post, :only => [:edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.order('created_at DESC')
  end

  def new
    @blog_post.published ||= true
  end

  def create
    @blog_post.save!
    flash[:notice] = 'Blog post created'
    redirect_to :action => :edit, :id => @blog_post
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def edit
    # ...
  end

  def update
    @blog_post.update_attributes!(params[:blog_post])
    flash[:notice] = 'Post updated'
    redirect_to :action => :edit, :id => @blog_post
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  def destroy
    @blog_post.destroy

    flash[:notice] = 'Post removed'
    redirect_to :action => :index
  end

protected
  def build_blog_post
    @blog_post = BlogPost.new(params[:blog_post])
  end
  
  def load_blog_post
    @blog_post = BlogPost.find_by_id(params[:id].to_i)
  end
end