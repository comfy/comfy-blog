class Comfy::Blog::CommentsController < Comfy::Blog::BaseController

  before_action :load_post,
                :build_comment

  def create
    @comment.save!

    flash[:success] = t('comfy.admin.blog.comments.created')
    redirect_to comfy_blog_post_path(@cms_site.path, @blog.path, @post.slug)

  rescue ActiveRecord::RecordInvalid
    flash[:error] = t('comfy.admin.blog.comments.create_failure')
    render 'comfy/blog/posts/show'
  end

protected

  def load_post
    @post = @blog.posts.published.where(:slug => params[:slug]).first!
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('comfy.admin.blog.posts.not_found')
    redirect_to comfy_blog_posts_path(@cms_site.path, @blog.path)
  end

  def build_comment
    @comment = @post.comments.new(comment_params)
  end

  def comment_params
    params.fetch(:comment, {}).permit(:author, :email, :content)
  end
end
