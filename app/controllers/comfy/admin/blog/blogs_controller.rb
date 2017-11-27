class Comfy::Admin::Blog::BlogsController < Comfy::Admin::Blog::BaseController

  before_action :build_blog,  only: [:new, :create]
  before_action :load_blog,   only: [:edit, :update, :destroy]

  def index
    return redirect_to action: :new if @site.blogs.count == 0
    @blogs = @site.blogs
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @blog.save!
    flash[:success] = t('.created')
    redirect_to action: :edit, id: @blog
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] =  t('.create_failure')
    render action: :new
  end

  def update
    @blog.update_attributes!(blog_params)
    flash[:success] = t('.updated')
    redirect_to action: :edit, id: @blog
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t('.update_failure')
    render action: :edit
  end

  def destroy
    @blog.destroy
    flash[:success] = t('.deleted')
    redirect_to action: :index
  end

protected

  def build_blog
    @blog = @site.blogs.new(blog_params)
  end

  def blog_params
    params.fetch(:blog, {}).permit!
  end
end
