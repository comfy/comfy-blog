# frozen_string_literal: true

ComfyBlog::Application.routes.draw do
  comfy_route :cms_admin
  comfy_route :blog_admin
  comfy_route :blog
  comfy_route :cms
end
