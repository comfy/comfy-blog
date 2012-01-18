Rails.application.routes.draw do
  
  scope :module => :blog do
    namespace :admin, :path => SofaBlog.config.admin_route_prefix do
      resources :posts do
        resources :comments, :only => [:index]
      end
      resources :comments, :only => [:index] do
        put :publish, :on => :member
      end
      resources :tags
    end unless SofaBlog.config.admin_route_prefix.blank?
  end
  
  scope SofaBlog.config.public_route_prefix, :module => :blog do
    get '/'                   => 'posts#index', :as => :blog_posts
    get '/tag/:tag'           => 'posts#index', :as => :tagged_blog_posts
    get '/category/:category' => 'posts#index', :as => :categorized_blog_posts
    
    with_options :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ } do |o|
      o.get ':year'               => 'posts#index', :as => :year_blog_posts
      o.get ':year/:month'        => 'posts#index', :as => :month_blog_posts
      o.get ':year/:month/:slug'  => 'posts#show',  :as => :blog_post
    end
  end
  
end
