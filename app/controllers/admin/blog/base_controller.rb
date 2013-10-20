class Admin::Blog::BaseController < Admin::Cms::BaseController

protected

  def load_blog
    @blog = @site.blogs.find(params[:blog_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog not found'
    redirect_to admin_blogs_path(@site)
  end
  
end