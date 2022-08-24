class Comfy::Blog::CategoriesController < Comfy::Blog::BaseController
  before_action :load_blog

  def index
    scope = @blog.site.categories.of_type('Comfy::Blog::Post')
    respond_to do |format|
      format.html do
        @categories = comfy_paginate(scope, 100)
      end
    end
  end

  def show
    @category = Comfy::Cms::Category.find_by_slug!(params[:slug])
    @posts = @blog.posts.for_category(@category.label)
  end
end
