class Comfy::Blog::PostsController < Comfy::Blog::BaseController

  skip_before_action :load_blog, :only => [:serve]

  # due to fancy routing it's hard to say if we need show or index
  # action. let's figure it out here.
  def serve
    # if there are more than one blog, blog_path is expected
    if @cms_site.blogs.count >= 2
      params[:blog_path] = params.delete(:slug) if params[:blog_path].blank?
    end

    load_blog

    if params[:slug].present?
      show && render(:show)
    else
      index && render(:index)
    end
  end

  def index
    scope = if params[:year]
      scope = @blog.posts.published.for_year(params[:year])
      params[:month] ? scope.for_month(params[:month]) : scope
    else
      @blog.posts.published
    end

    limit = ComfyBlog.config.posts_per_page
    respond_to do |f|
      f.html do
        @posts = if defined? WillPaginate
          scope.paginate :per_page => ComfyBlog.config.posts_per_page, :page => params[:page]
        elsif defined? Kaminari
          scope.page(params[:page]).per(ComfyBlog.config.posts_per_page)
        else
          scope
        end
      end
      f.rss do
        @posts = scope.limit(ComfyBlog.config.posts_per_page)
      end
    end
  end

  def show
    @post = if params[:slug] && params[:year] && params[:month]
      @blog.posts.published.where(:year => params[:year], :month => params[:month], :slug => params[:slug]).first!
    else
      @blog.posts.published.where(:slug => params[:slug]).first!
    end
    @comment = @post.comments.new

  rescue ActiveRecord::RecordNotFound
    render :cms_page => '/404', :status => 404
  end

end
