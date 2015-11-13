class Comfy::Admin::Blog::PostsController < Comfy::Admin::Blog::BaseController

  before_action :load_blog
  before_action :build_post, :only => [:new, :create]
  before_action :load_post,  :only => [:edit, :update, :destroy]
  before_action :authorize
  
  def index
    @posts = comfy_paginate(@blog.posts.order(:published_at))
  end

  def new
    @post.author = ComfyBlog.config.default_author
    render
  end

  def create
    @post.save!
    flash[:success] = t('comfy.admin.blog.posts.created')
    redirect_to :action => :edit, :id => @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('comfy.admin.blog.posts.create_failure')
    render :action => :new
  end

  def edit
    render
  end

  def update
    @post.update_attributes!(post_params)
    flash[:success] = t('comfy.admin.blog.posts.updated')
    redirect_to :action => :edit, :id => @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('comfy.admin.blog.posts.update_failure')
    render :action => :edit
  end

  def destroy
    @post.destroy
    flash[:success] = t('comfy.admin.blog.posts.deleted')
    redirect_to :action => :index
  end

protected

  def load_post
    @post = @blog.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('comfy.admin.blog.posts.not_found')
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
