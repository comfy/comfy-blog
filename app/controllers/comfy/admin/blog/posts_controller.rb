class Comfy::Admin::Blog::PostsController < Comfy::Admin::Blog::BaseController

  before_action :load_blog
  before_action :build_post, only: [:new, :create]
  before_action :load_post,  only: [:edit, :update, :destroy]

  def index
    return redirect_to action: :new if @blog.posts.count == 0

    posts_scope = @blog.posts.
      includes(:categories).for_category(params[:categories]).order(:published_at)
    @posts = comfy_paginate(posts_scope)
  end

  def new
    render
  end

  def create
    @post.save!
    flash[:success] = t('.created')
    redirect_to action: :edit, id: @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t('.create_failure')
    render action: :new
  end

  def edit
    render
  end

  def update
    @post.update_attributes!(post_params)
    flash[:success] = t('.updated')
    redirect_to action: :edit, id: @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t('.update_failure')
    render action: :edit
  end

  def destroy
    @post.destroy
    flash[:success] = t('.deleted')
    redirect_to action: :index
  end

protected

  def load_post
    @post = @blog.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = t('.not_found')
    redirect_to action: :index
  end

  def build_post
    @post = @blog.posts.new(post_params)
    @post.published_at ||= Time.zone.now
  end

  def post_params
    params.fetch(:post, {}).permit!
  end
end
