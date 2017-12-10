class Comfy::Admin::Blog::Revisions::PostController < Comfy::Admin::Cms::Revisions::BaseController

  def show
    @current_content = @record.fragments.each_with_object({}) do |b, c|
      c[b.identifier] = b.content
    end
    @versioned_content = @record.fragments.each_with_object({}) do |b, c|
      data = @revision.data['fragments_attributes'].detect{|r| r[:identifier] == b.identifier}
      c[b.identifier] = data.try(:[], :content)
    end

    render "comfy/admin/cms/revisions/show"
  end

private

  def load_record
    @record = @site.blog_posts.find(params[:blog_post_id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = I18n.t('comfy.admin.cms.revisions.record_not_found')
    redirect_to comfy_admin_blog_posts_path(@site)
  end

  def record_path
    edit_comfy_admin_blog_post_path(@site, @record)
  end

end
