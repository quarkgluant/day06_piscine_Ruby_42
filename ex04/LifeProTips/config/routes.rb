Rails.application.routes.draw do

  # ------ début ex02 modifié pour l'ex04 ---------------------------------

  resources :posts do
    resource :vote, module: :posts
  end

  # ------ fin ex02 modifié pour l'ex04 -----------------------------------

  # inscription avec le formulaire
  get 'users/sign_in' => 'users#sign_in', as: :sign_in

  # action POST quand le formulaire est soumis
  post 'users' => 'users#create'

  # ----- add these lines here for session: -----

  # log in page with form:
  get '/login' => 'sessions#new', as: :login

  # create (post) action for when log in form is submitted:
  post '/login' => 'sessions#create'

  # delete action to log out:
  delete 'users/logout' => 'sessions#destroy', as: :logout

  # ----- end of added lines for session -----

  # ---- début ex01 ----------------------------------

  namespace :admin do
    resources :users, except: %i[new create]
    # ----- début ex04 ---------------------------------
    resources :votes, only: :index
    # ----- fin ex04 -----------------------------------
    # ----- début ex02 ---------------------------------
    resources :posts do
      # ----- début ex04 ---------------------------------
      resource :vote, only: [:create, :destroy]
      # ----- fin ex04 -----------------------------------
    end
    # ----- fin ex02 -----------------------------------
  end

  resources :users, only: %i[edit update]

  # ---- fin ex01 ------------------------------------
  # root 'users#home': :index

  get '/home' => 'users#home', as: :home
  root 'posts#index'

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
