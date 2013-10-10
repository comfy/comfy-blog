class Blog::PostsController < Cms::BaseController
  
  def index
    scope = if params[:year]
      scope = Blog::Post.published.for_year(params[:year])
      params[:month] ? scope.for_month(params[:month]) : scope
    else
      Blog::Post.published
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
      Blog::Post.published.where(:year => params[:year], :month => params[:month], :slug => params[:slug]).first!
    else
      Blog::Post.published.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    render :cms_page => '/404', :status => 404
  end
  
protected

  def load_cms_site
    super
    if @cms_site.path.blank? && params[:cms_path].present?
      raise ActionController::RoutingError.new('Site Not Found')
    end
  end
  
end