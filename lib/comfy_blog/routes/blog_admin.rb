class ActionDispatch::Routing::Mapper
  
  def comfy_route_blog_admin(options = {})
    options[:path] ||= 'admin'
    path = [options[:path], 'sites', ':site_id'].join('/')
    
    scope :module => :admin do
      namespace :blog, :as => :admin, :path => path, :except => [:show] do
        resources :blogs do
          resources :posts
          resources :comments, :only => [:index, :destroy] do
            patch :toggle_publish, :on => :member
          end
        end
      end
    end
  end
end