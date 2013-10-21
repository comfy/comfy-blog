class Blog::PostsController < Blog::BaseController

  def index
    scope = if params[:year]
      scope =@blog.posts.published.for_year(params[:year])
      params[:month] ? scope.for_month(params[:month]) : scope
    else
      @blog.posts.published
    end

    limit = ComfyBlog.config.posts_per_page
    respond_to do |format|
      format.html do
        @posts = scope.page(params[:page]).per(limit)
      end
      format.rss do
        @posts = scope.limit(limit)
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