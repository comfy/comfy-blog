Rails.application.routes.draw do

  namespace :cms_admin, :path => ComfortableMexicanSofa.config.admin_route_prefix do
    resources :blog_posts do
      resources :blog_comments do
        member do
          put :approve
          put :disapprove
        end
      end
    end
  end
  
end