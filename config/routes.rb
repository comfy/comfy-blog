Rails.application.routes.draw do
  
  namespace :sofa_blog, :path => '' do

    resources :posts, :only => [:show, :index], :path => 'blog'
    
    namespace :admin, :path => SofaBlog.config.admin_route_prefix do
      resources :posts do
        resources :comments do
          member do
            put :approve
            put :disapprove
          end
        end
      end
    end unless SofaBlog.config.admin_route_prefix.blank?
  end 
  
end
