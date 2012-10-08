Saint::Application.routes.draw do

  match '/signin',		to: 'sessions#new'
  match '/signout',		to: 'sessions#destroy', via: :delete
  match '/dashboard',	to: 'dashboard_trended_metrics#index'

  resources :cloud_matches do
    collection do
      get 'upload'
      post 'process_upload'
      post 'sort'
    end
  end

  resources :clouds

  resources :brand_matches do
    collection do
      get 'upload'
      post 'process_upload'
      post 'sort'
    end
  end
  
  resources :classifications do
    collection do
      get 'run'
    end
    member do
      get 'run'
    end
  end
  
  resources :sites

  resources :suites
  
  resources :users
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :dashboard_trended_metrics do
    collection do
      get 'visits'
      get 'form_completes'
    end
  end
  
  resources :dashboard_driver_types do
    collection do
      get 'visits'
      get 'form_completes'
    end
  end
  
  resources :dashboard_clouds do
    collection do
      get 'page_views'
      get 'form_completes'
    end
  end
  
  resources :dashboard_offer_types do
    collection do
      get 'form_views'
      get 'form_completes'
      get 'form_complete_rate'
    end
  end
  
  resources :dashboard_video_names do
    collection do
      get 'video_starts'
      get 'video_completes'
    end
  end
  
  root :to => 'classifications#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #root :to => 'users#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
