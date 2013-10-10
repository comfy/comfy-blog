module ComfyBlog::Routing
  
  def self.admin(options = {})
    options[:path] ||= 'admin'
    path = [options[:path], 'sites', ':site_id', 'blog'].join('/')
    
    Rails.application.routes.draw do
      scope :module => :admin do
        namespace :blog, :as => :admin_blog, :path => path, :except => :show do
          resources :posts
          resources :comments, :only => [:index, :destroy] do
            patch :toggle_publish, :on => :member
          end
        end
      end
    end
  end
  
  def self.content(options = {})
    Rails.application.routes.draw do
      
      namespace :blog, :path => options[:path] do
        resources :posts, :only => [:index, :show] do
          resources :comments, :only => [:create]
        end
        with_options :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ } do |o|
          o.get ':year'               => 'posts#index', :as => :posts_of_year
          o.get ':year/:month'        => 'posts#index', :as => :posts_of_month
          o.get ':year/:month/:slug'  => 'posts#show',  :as => :posts_dated
        end
      end
    end
  end
  
end