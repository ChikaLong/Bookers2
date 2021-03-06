Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: 'homes#top'
  get "/home/about" => "homes#about"

  resources :books,only:[:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end

  resources :users,only:[:index,:show,:edit,:update] do
    resource :relationships,only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :rooms, only:[:create, :show]
  resources :messages, only:[:create]

  get '/search' => 'searches#search'

end
