class ActionDispatch::Routing::Mapper

  def comfy_route_blog(options = {})
    options[:path] ||= 'blog'
    path = ['(:cms_path)', options[:path], '(:blog_path)'].join('/')
    
    scope :module => :comfy, :as => :comfy do
      namespace :blog, :path => path, :constraints => {:blog_path => /\w[a-z0-9_-]*/} do
        with_options :constraints => {:year => /\d{4}/, :month => /\d{1,2}/} do |o|
          o.get ':year'               => 'posts#index', :as => :posts_of_year
          o.get ':year/:month'        => 'posts#index', :as => :posts_of_month
          o.get ':year/:month/:slug'  => 'posts#show',  :as => :posts_dated
        end
        get 'categories'      => 'categories#index', :as => :categories
        get 'categories/:slug' => 'categories#show', :as => :category

        post ':slug/comments' => 'comments#create', :as => :comments
        get  ':slug'          => 'posts#serve',     :as => :post
        get  '/'              => 'posts#serve',     :as => :posts
      end
    end
  end
end