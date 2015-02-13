ComfyBlog::Application.routes.draw do
  comfy_route :cms_admin
  comfy_route :blog_admin
  comfy_route :blog
  comfy_route :cms, :sitemap => true
  comfy_route :tags, :path => 'articles#index', as: :tag
end
