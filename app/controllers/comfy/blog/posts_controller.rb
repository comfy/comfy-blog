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
    scope = @blog.posts.published

    if params[:year]
      scope = scope.for_year(params[:year])
      scope = scope.for_month(params[:month]) if params[:month]
    end

    scope = scope.for_category(params[:category]) if params[:category]

    limit = ComfyBlog.config.posts_per_page
    respond_to do |format|
      format.html do
        @posts = comfy_paginate(scope, limit)
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
    return
  end

end
