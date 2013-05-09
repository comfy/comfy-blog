module ComfyBlog::Routing

  def self.admin
    Rails.application.routes.draw do
      namespace :admin, :path => ComfyBlog.config.admin_route_prefix do
        namespace :blog do
          resources :posts, :except => [:show] do
            unless ComfyBlog.disqus_enabled?
              resources :comments, :only => [:index]
            end
          end
          unless ComfyBlog.disqus_enabled?
            resources :comments, :only => [:index, :destroy] do
              put :publish, :on => :member
            end
          end
          resources :tags, :except => [:show]
        end
      end unless ComfyBlog.config.admin_route_prefix.blank?
    end
  end

  def self.content
    Rails.application.routes.draw do
      scope ComfyBlog.config.public_route_prefix, :module => :blog do
        get '/'                   => 'posts#index', :as => :blog_posts
        get 'tag/:tag'            => 'posts#index', :as => :tagged_blog_posts
        get 'category/:category'  => 'posts#index', :as => :categorized_blog_posts

        with_options :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ } do |o|
          o.get ':year'               => 'posts#index', :as => :year_blog_posts
          o.get ':year/:month'        => 'posts#index', :as => :month_blog_posts
          o.get ':year/:month/:slug'  => 'posts#show',  :as => :dated_blog_post
        end

        unless ComfyBlog.disqus_enabled?
          post ':post_id/comments' => 'comments#create', :as => :blog_post_comments
        end

        get ':id' => 'posts#show', :as => :blog_post
      end
    end
  end

end
