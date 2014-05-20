Zrcle::Application.routes.draw do
  match '/goals/:goal_id/users/:user_id', to: 'user_goals#create_by_goals', via: [:post]
  match '/users/:user_id/goals/:goal_id', to: 'user_goals#create_by_users', via: [:post]
  match 'users/:user_id/goals/:goal_id/current_step', to: 'user_steps#current_step', via: [:get]

  get 'goals/search_by_name/:text', to: 'goals#search_by_name'
  get 'goals/search_by_category/:text', to: 'goals#search_by_category'
  get 'users/:id/random', to: 'users#random_user'
  get 'friendships/get_friends/:user_id', to: 'friendships#get_friends'
  get 'friendships/get_friends_by_name/:text', to: 'friendships#get_friends_by_name'
  get 'users/:id/motivational_sent', to: 'comments#motivational_sent'
  get 'users/:id/motivational_received', to: 'comments#motivational_received'
  get 'users/:user_id/goals/:goal_id/friends', to: 'friendships#get_friends_by_goal'
  get 'users/:user_id/requests_received', to: 'friendships#requests_friend_received'
  get 'users/:user_id/requests_sent', to: 'friendships#requests_friend_sent'
  get 'goals/:id/users/:user_id/users_by_goal', to: 'goals#get_users_by_goal'

  post 'users/login', to: 'users#login'
  post 'users/login', to: 'users#login'
  post 'users/:user_id/goals/:goal_id/step_complete', to: 'user_steps#step_complete'

  patch 'goals/:id/goal_image', to: 'goals#goal_image'
  patch 'goal_categories/:id/category_image', to: 'goal_categories#category_image'
  patch 'users/:id/user_image', to: 'users#user_image'
  patch 'users/:user_id/goals/:goal_id/disable', to: 'user_goals#disable_goal'
  patch 'users/:id/edit_user', to: 'users#edit_user'

  resources :goals do
    resources :goal_types, only: [:index]
    resources :user_goals, only: [:index, :delete]
    resources :goal_categories, only: [:index]
    resources :users, only: [:index]
    resources :goal_reminds, only: [:index]
    resources :goal_rates, only: [:index]
    resources :goal_steps, only: [:index]
    resources :comments, only: [:index]
    resources :follow_goals, only: [:index]
    resources :user_steps, only: [:index]
    resources :posts
  end
  resources :users do
    resources :user_goals, only: [:index, :destroy]
    resources :goals, only: [:index, :show]
    resources :user_configurations, only: [:index]
    #resources :profiles, only: [:index]
    resources :follow_goals, only: [:index]
    resources :follow_users, only: [:index]
    resources :friendships, only: [:index]
    resources :user_steps, only: [:index, :delete]
    resources :posts
  end
  #resources :comment_likes
  #resources :comment_replies
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
  #resources :goal_rates
  #resources :goal_reminds
  resources :goal_steps
  resources :goal_types do
    resources :goals
  end
  #resources :profiles
  #resources :user_configurations
  resources :user_goals do
    resources :goals, only: [:index]
    resources :users, only: [:index]
  end
  #resources :user_levels
  resources :user_steps
  resources :levels
  resources :posts




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
