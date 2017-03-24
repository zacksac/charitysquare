Rails.application.routes.draw do
 
  post '/rate' => 'rater#create', :as => 'rate'
  # resources :bets

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users ,:controllers => {:registrations => "user/registrations", :sessions => "user/sessions"}
  devise_scope :user do
  get "/sign_in" => "home#login"
  get "/sign_up"   => "home#user_signup"
  get "/charity_signup"   => "home#charity_signup"
  get "/account_settings"   => "home#account_settings"
  end

  resources :mysquares
  resources :squares
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root 'home#index'
  match '/searching'    => 'home#searching', :via => [:get,:post]
  match '/bets/create' =>'bets#create' , :via =>[:get,:post]
  match '/appeals/create' =>'appeals#create' , :via =>[:get,:post]
  match '/pay' => 'home#pay', :via => [:get,:post]
  get '/search' => 'home#search'
  match '/charity'    => 'charityusersquares#charity', :via => [:get,:post]
  match '/charity/upload'    => 'charity_media#upload', :via => [:get,:post]
  resources :charitychildren

  match '/profile'    => 'home#profile', :via => [:get,:post]
  match '/profile_edit/:id'    => 'home#profile_edit', :via => [:get,:post]
  match '/edit_profile'    => 'home#edit_profile', :via => [:get,:post,:patch]

  get '/charity/remove/:id', to: 'charity_media#remove_picture', as: 'remove_picture'

  match '/charityusersquares/buynow/:id' => 'charityusersquares#buynow' ,as: 'charitybuy_path' ,:via =>[:get,:post]

  resources :charityusersquares
 
  match '/charity_squares'    => 'home#charity_squares', :via => [:get,:post]
  match '/buy_now'    => 'home#buy_now', :via => [:get,:post]
  # match '/bets'    => 'home#bets', :via => [:get,:post]
  match '/bets/:id/edit'    => 'bets#edit', :via => [:get,:post]
  match '/bets/:id'    => 'bets#show', as: 'bets_show', :via => [:get,:post]
  match '/update_bet' =>'bets#update' , :via => [:get,:post]
  match '/bets/remove/:id' => 'bets#delete', :via => [:get,:post]
  match '/appeal/:id/edit'    => 'appeals#edit', :via => [:get,:post]
  match '/appeal/:id'    => 'appeals#show', as: 'appeals_show', :via => [:get,:post]
  match '/update_appeal' =>'appeals#update' , :via => [:get,:post]
  match '/auctions'    => 'home#auctions', :via => [:get,:post]
  match '/appeals'    => 'home#appeals', :via => [:get,:post]
  match '/raffle_n_lottery'    => 'home#raffle_n_lottery', :via => [:get,:post]

  match '/view_transaction'    => 'home#view_transaction', :via => [:get,:post]

  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      delete :empty_trash
      post :mark_as_read
    end
  end

  resources :messages, only: [:new, :create]
  match '/home_page_feed'    => 'home#home_page_feed', :via => [:get,:post]
  match '/search_filter'    => 'home#search_filter', :via => [:get,:post]
  match '/filter'    => 'home#filter', :via => [:get,:post]

  match '/completed_payment_request'    => 'home#completed_payment_request', :via => [:get,:post]
  match '/ipn_notification'    => 'home#ipn_notification', :via => [:get,:post]
  match '/appeal_ipn'  => 'appeals#appeal_ipn', :via => [:get,:post]

  match '/my_square'    => 'home#my_square', :via => [:get,:post]
  
  match '/profile'    => 'home#profile', :via => [:get,:post]
  match '/follow'    => 'charityusersquares#follow', :via => [:get,:post]
  match '/follows'    => 'bets#follows', :via => [:get,:post]
  match '/order_summary'    => 'home#order_summary', :via => [:get,:post]
  match '/bet_response'    => 'bets#bet_response', :via => [:get,:post]
  match '/bet_removepic'    => 'bets#removepic', :via => [:get,:post]
  match '/appeal_donations' => 'appeals#appeal_donations', :via => [:get,:post]
  match '/appeal_removepic'    => 'appeals#removepic', :via => [:get,:post] 
  match '/bet_result/:id'    => 'bets#bet_result', as: 'bet_result', :via => [:get,:post]
  match '/bet_result1/:id'    => 'bets#bet_result1', as: 'bet_result1', :via => [:get,:post]
  match '/view_donations/:id'  => 'appeals#view_donations', as: 'view_donations', :via => [:get,:post]
  match '/purchase/result/:id'    => 'home#purchase_result', as: 'purchase_result', :via => [:get,:post]
  match '/invite'    => 'bets#invite', :via => [:get,:post]


  match '/approve'  => 'bets#approve', :via =>[:get,:post]
  match '/purchase' => 'home#manage_purchase', :via =>[:get,:post]

  match '/checkout'    => 'home#checkout', :via => [:get,:post]
  match '/order_confirmation'    => 'home#order_confirmation', :via => [:get,:post]
  match '/view_transaction'    => 'home#view_transaction', :via => [:get,:post]
  match '/select'    => 'home#select', :via => [:get,:post]
  match '/create_square'    => 'charityusersquares#create_square', :via => [:get,:post]
  match '/bet'    => 'charityusersquares#bet', :via => [:get,:post]
  match '/appeal'  => 'charityusersquares#appeal', :via => [:get,:post]
  # match '/account_settings'    => 'home#account_settings', :via => [:get,:post]

  # Example of named route that can be invoked with purchase_url(id: product.id)
  # match '/connect' => 'charityusersquares#connect', :via => [:get,:post]
  # match '/callback' => 'charityusersquares#callback', :via => [:get,:post]
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
