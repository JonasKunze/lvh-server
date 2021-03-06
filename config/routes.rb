Rails.application.routes.draw do

  get 'stats/json'
  get 'snippets/json'
  get 'snippets/json2'

  resources :stats do
    resources :stats
  end

  resources :snippets do
    member { get 'time_remaining' }
    resources :ratings
  end

  resources :ratings
  resources :users
  
  resources :rating_marks do
    resources :ratings
  end

  resources :settings
  get 'welcome/index'
  get 'viewer/index'
  get 'viewer/current_snippet', as: 'current_snippet'
  get 'viewer/next_snippet/:snippet_id' => 'viewer#next_snippet', as: 'next_snippet'
  get 'viewer/prev_snippet/:snippet_id' => 'viewer#prev_snippet', as: 'prev_snippet'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'viewer#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
