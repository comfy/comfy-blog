class ActionDispatch::Routing::Mapper

  def comfy_route_blog(options = {})
    options[:path] ||= 'blog'
    path = ['(:cms_path)', options[:path]].join('/')

    scope module: :comfy, as: :comfy do
      namespace :blog, path: path do
        with_options constraints: {year: /\d{4}/, month: /\d{1,2}/} do |o|
          o.get ':year',              to: 'posts#index',  as: :posts_of_year
          o.get ':year/:month',       to: 'posts#index',  as: :posts_of_month
          o.get ':year/:month/:slug', to: 'posts#show',   as: :post
          o.get '/',                  to: 'posts#index',  as: :posts
        end
      end
    end
  end
end
