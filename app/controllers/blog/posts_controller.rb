class Blog::PostsController < ApplicationController
  
  layout ComfyBlog.config.public_layout
  
  def index
    scope = if params[:tag]
      Blog::Post.published.tagged_with(params[:tag])
    elsif params[:category]
      Blog::Post.published.categorized_as(params[:category])
    elsif params[:year]
      scope = Blog::Post.published.for_year(params[:year])
      params[:month] ? scope.for_month(params[:month]) : scope
    else
      Blog::Post.published
    end
    
    respond_to do |f|
      f.html do
        @posts = scope.paginate :per_page => ComfyBlog.config.posts_per_page, :page => params[:page]
      end
      f.rss do
        @posts = scope.limit(ComfyBlog.config.posts_per_page)
      end
    end
  end
  
  def show
    @post = if params[:slug] && params[:year] && params[:month]
      Blog::Post.published.find_by_year_and_year_and_slug!(params[:year], params[:month], params[:slug])
    else
      Blog::Post.published.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    if defined? ComfortableMexicanSofa
      render :cms_page => '/404', :status => 404
    else
      render :text => 'Post not found', :status => 404
    end
  end
end
