class SofaBlog::PostsController < ApplicationController
  
  def index
    @posts = SofaBlog::Post.published.paginate(
      :page     => params[:page],
      :per_page => SofaBlog.config.posts_per_page
    )
  end
  
  def show
    @post = SofaBlog::Post.published.find(params[:id])
    
  rescue ActiveRecord::RecordNotFound
    if defined? ComfortableMexicanSofa
      render :cms_page => '/404', :status => 404
    else
      render :text => 'Post not found', :status => 404
    end
  end
end
