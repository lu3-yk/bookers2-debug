Rails.application.routes.draw do
  
  devise_for :users
  get 'chats/show'
  get 'rooms/create'
  get 'rooms/show'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
  post "search_result" => "search_result#search"
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "search", to: "users#search"
  end
  
  
  resources :books do
   resources:book_comments,only: [:create,:destroy,]
    resource :favorites, only: [:create, :destroy]
  
  end 
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show] 
  resources :groups, except: [:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end