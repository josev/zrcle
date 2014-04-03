Zrcle::Application.routes.draw do

  match '/goals/:goal_id/users/:id', to: 'user_goals#create_by_goals',:via => [:post]
  match '/users/:user_id/goals/:id', to: 'user_goals#create_by_users',:via => [:post]
  get 'goals/search_by_name/:text', to: 'goals#search_by_name'
  get 'goals/search_by_category/:text', to: 'goals#search_by_category'
  get 'users/login', to: 'users#login'
  get 'users/random', to: 'users#random_user'
  get 'friendships/get_friends/:id', to: 'friendships#get_friends'
  get 'friendships/get_friends_by_name/:text', to: 'friendships#get_friends_by_name'

  resources :goals do
    resources :goal_types, only: [:index]
    resources :user_goals, only: [:index]
    resources :goal_categories, only: [:index]
    resources :users, only: [:index]
    resources :goal_reminds, only: [:index]
    resources :goal_rates, only: [:index]
    resources :goal_step_calendars, only: [:index]
    resources :comments, only: [:index]
    resources :follow_goals, only: [:index]
  end
  resources :users do
    resources :user_goals, only: [:index]
    resources :goals, only: [:index]
    resources :user_configurations, only: [:index]
    resources :profiles, only: [:index]
    resources :follow_goals, only: [:index]
    resources :friendships, only: [:index]
  end
  resources :comment_likes
  resources :comment_replies
  resources :comments do
    resources :comment_replies, only: [:index]
    resources :comment_likes, only: [:index]
  end
  resources :follow_goals
  resources :follow_users
  resources :friendships
  resources :goal_categories do
    resources :goals, only: [:index]
  end
  resources :goal_rates
  resources :goal_reminds
  resources :goal_step_calendars
  resources :goal_types do
    resources :goals
  end
  resources :profiles
  resources :user_configurations
  resources :user_goals do
    resources :goals, only: [:index]
    resources :users, only: [:index]
  end
  resources :user_levels




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
