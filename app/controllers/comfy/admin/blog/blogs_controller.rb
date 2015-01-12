class Comfy::Admin::Blog::BlogsController < Comfy::Admin::Blog::BaseController

  before_action :build_blog,  :only => [:new, :create]
  before_action :load_blog,   :only => [:edit, :update, :destroy]

  def index
    @blogs = comfy_paginate(@site.blogs)
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @blog.save!
    flash[:success] = 'Blog created'
    redirect_to :action => :edit, :id => @blog
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Blog'
    render :action => :new
  end

  def update
    @blog.update_attributes!(blog_params)
    flash[:success] = 'Blog updated'
    redirect_to :action => :edit, :id => @blog
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Blog'
    render :action => :edit
  end

  def destroy
    @blog.destroy
    flash[:success] = 'Blog deleted'
    redirect_to :action => :index
  end

protected

  def build_blog
    @blog = @site.blogs.new(blog_params)
  end

  def blog_params
    params.fetch(:blog, {}).permit!
  end
end