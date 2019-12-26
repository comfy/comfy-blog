# frozen_string_literal: true

class Comfy::Admin::Blog::PostsController < Comfy::Admin::Cms::BaseController

  before_action :build_post, only: %i[new create]
  before_action :load_post,  only: %i[edit update destroy]
  before_action :authorize

  def index
    return redirect_to action: :new if @site.blog_posts.count.zero?

    posts_scope = @site.blog_posts
      .includes(:categories)
      .for_category(params[:categories])
      .order(published_at: :desc)
    @posts = comfy_paginate(posts_scope)
  end

  def new
    render
  end

  def create
    @post.save!
    flash[:success] = t(".created")
    redirect_to action: :edit, id: @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t(".create_failure")
    render action: :new
  end

  def edit
    render
  end

  def update
    @post.update!(post_params)
    flash[:success] = t(".updated")
    redirect_to action: :edit, id: @post

  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t(".update_failure")
    render action: :edit
  end

  def destroy
    @post.destroy
    flash[:success] = t(".deleted")
    redirect_to action: :index
  end

  def form_fragments
    @post = @site.blog_posts.find_by(id: params[:id]) || @site.blog_posts.new
    @post.layout = @site.layouts.find_by(id: params[:layout_id])

    render(
      partial:  "comfy/admin/cms/fragments/form_fragments",
      locals:   { record: @post, scope: :post },
      layout:   false
    )
  end

protected

  def load_post
    @post = @site.blog_posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = t(".not_found")
    redirect_to action: :index
  end

  def build_post
    layout = (@site.blog_posts.order(:created_at).last.try(:layout) || @site.layouts.order(:created_at).first)
    @post = @site.blog_posts.new(post_params)
    @post.published_at ||= Time.zone.now
    @post.layout ||= layout
  end

  def post_params
    params.fetch(:post, {}).permit!
  end

end
