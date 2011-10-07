class SofaBlog::PostsController < ApplicationController
  def index
    @posts = SofaBlog::Post.published.all
  rescue ActiveRecord::RecordNotFound
    render :text => 'Post not found', :status => 404
  end
  
  def show
    @post = SofaBlog::Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Post not found', :status => 404
  end
end
