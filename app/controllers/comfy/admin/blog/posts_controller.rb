class Comfy::Admin::Blog::PostsController < Comfy::Admin::Blog::BaseController

  before_action :load_blog
  before_action :build_post, :only => [:new, :create]
  before_action :load_post,  :only => [:edit, :update, :destroy]

  def index
    @posts = comfy_paginate(@blog.posts.order(:published_at))
  end

  def new
    @post.author = ComfyBlog.config.default_author
    render
  end

  def create
    @post.save!
    flash[:success] = 'Blog Post created'
    redirect_to :action => :edit, :id => @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Blog Post'
    render :action => :new
  end

  def edit
    render
  end

  def update
    @post.update_attributes!(post_params)
    flash[:success] = 'Blog Post updated'
    redirect_to :action => :edit, :id => @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Blog Post'
    render :action => :edit
  end

  def destroy
    @post.destroy
    flash[:success] = 'Blog Post removed'
    redirect_to :action => :index
  end

protected

  def load_post
    @post = @blog.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog Post not found'
    redirect_to :action => :index
  end

  def build_post
    @post = @blog.posts.new(post_params)
    @post.published_at ||= Time.zone.now
  end

  def post_params
    params.fetch(:post, {}).permit!
  end

end