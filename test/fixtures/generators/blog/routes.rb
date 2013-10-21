Test::Application.routes.draw do

  ComfyBlog::Routing.admin :path => '/admin'
  ComfyBlog::Routing.content :path => '/blog'

end