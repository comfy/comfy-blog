class ActionDispatch::Routing::Mapper

  def comfy_route_blog(options = {})
    options[:path] ||= 'blog'
    path = ['(:cms_path)', options[:path], '(:blog_path)'].join('/')

    scope module: :comfy, as: :comfy do
      namespace :blog, path: path, constraints: {:blog_path => /\w[a-z0-9_-]*/} do
        with_options constraints: {year: /\d{4}/, month: /\d{1,2}/} do |o|
          o.get ':year',              to: 'posts#index', as: :posts_of_year
          o.get ':year/:month',       to: 'posts#index', as: :posts_of_month
          o.get ':year/:month/:slug', to: 'posts#show',  as: :posts_dated
        end
        get  ':slug', to: 'posts#serve', as: :post
        get  '/',     to: 'posts#serve', as: :posts
      end
    end
  end
end
