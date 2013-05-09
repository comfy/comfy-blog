defined?(ComfyBlog::Application) && ComfyBlog::Application.routes.draw do
  ComfyBlog::Routing.admin
  ComfyBlog::Routing.content
end
