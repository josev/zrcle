Zrcle::Application.routes.draw do

  resources :goals do
    resources :goal_step_calendars, :comments,:follow_goals,:goal_rates, :user_goals, :goal_types
  end
  resources :users do
    resources :profiles, :user_configurations, :goal_reminds, :friendships, :user_levels, :user_goals
  end
  resources :comment_likes
  resources :comment_replies
  resources :comments do
    resources :comment_replies, :comment_likes
  end
  resources :follow_goals
  resources :follow_users
  resources :friendships
  resources :goal_categories do
    resources :goals
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
    resources :goals, :users
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
