class Comfy::Admin::Blog::CommentsController < Comfy::Admin::Blog::BaseController

  before_action :load_blog
  before_action :load_comment, :only => [:destroy, :toggle_publish]

  def index
    @comments = if @post = @blog.posts.where(:id => params[:post_id]).first
      comfy_paginate(@post.comments)
    else
      comfy_paginate(@blog.comments)
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = t('comfy.admin.blog.comments.deleted')
    redirect_to :action => :index
  end

  def toggle_publish
    @comment.update_attribute(:is_published, !@comment.is_published?)
  end

protected

  def load_comment
    @comment = @blog.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('comfy.admin.blog.comments.not_found')
    redirect_to :action => :index
  end

end
