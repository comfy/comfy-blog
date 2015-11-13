class Comfy::Admin::Blog::BaseController < Comfy::Admin::Cms::BaseController
  # Authorization module must have `authorize` method
  include ComfortableMexicanSofa.config.admin_authorization.to_s.constantize
  
protected

  def load_blog
    @blog = @site.blogs.find(params[:blog_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('comfy.admin.blog.blogs.not_found')
    redirect_to comfy_admin_blogs_path(@site)
  end

end
