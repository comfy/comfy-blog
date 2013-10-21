module ComfyBlog::Routing
  
  def self.admin(options = {})
    options[:path] ||= 'admin'
    path = [options[:path], 'sites', ':site_id'].join('/')
    
    Rails.application.routes.draw do
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
  
  def self.content(options = {})
    options[:path] ||= 'blog'
    path = ['(:cms_path)', options[:path], '(:blog_path)'].join('/')
    
    Rails.application.routes.draw do
      namespace :blog, :path => path, :constraints => {:blog_path => /\w[a-z0-9_-]*/} do
        with_options :constraints => {:year => /\d{4}/, :month => /\d{1,2}/} do |o|
          o.get ':year'               => 'posts#index', :as => :posts_of_year
          o.get ':year/:month'        => 'posts#index', :as => :posts_of_month
          o.get ':year/:month/:slug'  => 'posts#show',  :as => :posts_dated
        end
        post ':slug/comments' => 'comments#create', :as => :comments
        get  ':slug'          => 'posts#show',      :as => :post
        get  '/'              => 'posts#index',     :as => :posts
      end
    end
  end
end