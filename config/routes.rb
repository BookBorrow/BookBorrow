Rails.application.routes.draw do

  resources :books 

  root 'books#index'
  devise_for :users 
  devise_scope :user do
    # root to: "devise/sessions#new"
  end

  get 'users/:id' => 'users#show', :as => :user
  get 'users/:id/edit' => 'users#edit', :as => :edit_user
  delete 'user_books/:id' => 'user_books#destroy', as: :user_book
  
  # user_books
  post 'users/:user_id/user_books/' => 'user_books#create', :as => "user_user_books"

  # borrows
  post 'user_books/:user_book_id/borrows' => 'borrows#create', :as => "user_book_borrows"

  get '/user_books/:user_book_id/borrows/new' => 'borrows#new', :as => 'new_user_book_borrow'
  get '/user_books/:user_book_id/borrows/:id' => 'borrows#show', :as => 'user_book_borrow'

  get '/user_books/:user_book_id/borrows/:id/remind' => 'borrows#remind', :as => 'remind_user_book_borrow'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

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
