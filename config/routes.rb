Rails.application.routes.draw do
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "static_pages/about"
  get "static_pages/kanri"
  get "static_pages/member"
  
  
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :groups, only: [:index, :show, :new, :create, :destroy, :update ]

  resources :members, only: [:create, :update, :destroy, :edit, :show]

  resources :comments, only: [:create, :destroy]
  
  resources :roles, only: [:new, :create, :show, :index]
  
end
