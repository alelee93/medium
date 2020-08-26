Rails.application.routes.draw do

  #get 'comments/new'
  resources :posts, only: [:new, :create, :show, :index, :edit, :update, :delete, :destroy]
  resources :users, only: [:create]

  resources :users do 
    resources :posts, only: [:index]
  end

  resources :posts do 
    resources :comments, only: [:new, :create, :edit, :update, :delete, :destroy]
  end


  
  get '/auth/google_oauth2/callback', to: "sessions#create_with_omniauth"
  get '/signup', to: 'users#new'
  get '/home', to: 'users#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/my-interests', to: 'users#edit_tags', as: 'my_interests'
  patch '/my-interests', to: 'users#update_tags'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
