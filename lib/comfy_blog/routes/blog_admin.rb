class ActionDispatch::Routing::Mapper

  def comfy_route_blog_admin(options = {})
    options[:path] ||= "admin"
    path = [options[:path], "sites", ":site_id"].join("/")

    scope module: :comfy, as: :comfy do
      scope module: :admin do
        namespace :blog, as: :admin, path: path, except: [:show] do
          resources :posts, as: :blog_posts, path: "blog-posts" do
            resources :revisions, only: %i[index show], controller: "revisions/post" do
              patch :revert, on: :member
            end
          end
        end
      end
    end
  end
end
