ComfyBlog::Application.routes.draw do
  ComfortableMexicanSofa::Routing.admin
  ComfyBlog::Routing.admin
  ComfyBlog::Routing.content
  ComfortableMexicanSofa::Routing.content :sitemap => true
end