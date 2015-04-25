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

  # The location detail information page
  get 'locations/:id', to: 'locations#show'

  get "/comments/new", to: "comments#new"

end
