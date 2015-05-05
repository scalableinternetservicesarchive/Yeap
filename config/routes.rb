Rails.application.routes.draw do
  root 'static_pages#home'

  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users

  # The defalut home page, show a list of locations
  get 'locations', to: 'locations#index'
  
  # Like the specific location
  post "locations/:id/like", to: "locations#like", as: "like"

  # The location detail information page
  get 'locations/:id', to: 'locations#show', as: "location"

  # Create a new comment and show the form
  get "locations/:id/comments/new", to: "comments#new", as: "new_location_comments"
  # Create the comment and save it in the database
  post "locations/:id/comments", to: "comments#create", as: "location_comments"
  # Upvote the specific comments
  post "comments/:id/upvote", to: "comments#upvote", as: "upvote"
  # Downvote the specific comments
  post "comments/:id/downvote", to: "comments#downvote", as: "downvote"
end
