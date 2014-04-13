class Comfy::Admin::Blog::BaseController < Comfy::Admin::Cms::BaseController

protected

  def load_blog
    @blog = @site.blogs.find(params[:blog_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog not found'
    redirect_to comfy_admin_blogs_path(@site)
  end
  
end