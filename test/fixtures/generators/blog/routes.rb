Test::Application.routes.draw do

  comfy_route :blog_admin, path: "/admin"
  comfy_route :blog, path: "/blog"
end