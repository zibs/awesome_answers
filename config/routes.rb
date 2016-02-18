Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'questions#index'

  # the main job of the routes:
  # map a request to a controller with an action

  get "/hello" => "welcome#index"
  get "/about" => "welcome#about"
  get "/hello/:name" => "welcome#greet", as: :greet
  get "/subscribe" => "subscribe#index"
  post "/subscribe" => "subscribe#create"

  # helper method to make it easier to use new_question_path

  resources :questions do
    # targets general controller, not the particular record, *collection* of records
    get :search,      on: :collection
    # targeting a *particular* route that is of type question
    patch :mark_done, on: :member
    # nested route, has the full question_id
    post :approve
    # by defining 'resources' answers nesed inside 'resources :question' rails will define all the answers routes prepended wtih /questions/:question_id/...This enables us to have the question_id handy so that we can easily create a question with `question_id`.
    resources :answers, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  # AVOID TRIPLE NESTING COMMENTS UNDER RESOURCES
  # we don't need another set of answers routes, so we pass an empty string
  resources :answers, only: [:edit, :update] do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :edit, :update, :create, :destroy]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end


  #########################################################
  #########################################################



  ############
  # NEW
  ############
  # get "/questions/new" => "questions#new", as: :new_question # new question
  ############
  # CREATE
  ############
  # post "/questions" => "questions#create", as: :questions #create action
  ############
  # SHOW
  ############
  # get "/questions/:id" => "questions#show", as: :question #show action
  # the PATH for this URL (index action) is the same PATH for the POST action, so we can just use the one we defined for the create which is `questions_path`
  ############
  # INDEX
  ############
  # get "/questions" => "questions#index"
  ############
  # EDIT
  ############
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id" => "questions#update"
  ############
  # DELETE
  ############
  # delete "/questions/:id" => "questions#destroy"



  #########################################################
  #########################################################


  # as will give us a route helper method. it will ovveride the default one if any.
  # route helpers only look at the path portion of the route
  # and not the HTTP verb.
  # helper methods be unique.

  # get is a method from rails routes to help us repsonse to a GET request
  # hash as parameter:

  # get({"/hello" => "welcome#index"})
  # This will map any GET request with path "/hello" to the WelcomeController and
  # index action within it

  # Every use request in RAILS must be handled by a CONTROLLER and an ACTION

  #########################################################
  #########################################################
  #########################################################







  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
