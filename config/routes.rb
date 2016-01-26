Rails.application.routes.draw do

  devise_for :users
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'

  root 'index#welcome'

  get 'app' => 'huebook#index'

  resources :posts do
    member do
        get 'likes'
        get 'shares'
        post 'like'
        post 'unlike'
    end
    resources :comments do
        get 'likes'
        post 'like'
        post 'unlike'
    end
  end

  resource :walls do
    get '' => 'walls#default'
    get ':type/:id' => 'walls#show'
  end


  # TODO: Can we make this nicer? Like, generic action mapping?
  get 'search/users/:query', to: 'search#users'
  get 'search/posts/:query', to: 'search#posts'
  get 'search/events/:query', to: 'search#events'

  # TODO: Can this be nicer too?
  get  'friends', to: 'friendships#index'
  get  'friends/pending', to: 'friendships#pending'
  get  'friends/:id', to: 'friendships#show'
  post 'friends/:id/request', to: 'friendships#create'
  post 'friends/:id/accept', to: 'friendships#accept'
  post 'friends/:id/reject', to: 'friendships#reject'
  delete 'friends/:id/unfriend', to: 'friendships#unfriend'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
