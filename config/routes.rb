Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"
  
  resources :books
  resources :users, only: [:index,:show,:edit,:update,:destroy]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end