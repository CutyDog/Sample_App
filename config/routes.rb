Rails.application.routes.draw do

  get 'messages/index'
  get 'messages/create'
  root 'static_pages#home'  
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end  
  end  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :talks,               only: [:show, :create] do
    member do
      post :memberships, :messages
    end
  end 
  resources :memberships,         only: :destroy
  resources :messages,            only: :destroy
  resources :users, only: [:rss_micropost, :rss_feed] do
    member do
      get :rss_micropost, :rss_feed, defaults: { format: :rss }
    end  
  end
end
