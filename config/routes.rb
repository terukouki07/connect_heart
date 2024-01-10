Rails.application.routes.draw do
  #会員側のルーティング
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get "search" => "searches#search"
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :index, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :chats, only: [:create, :show]
  end

  #管理者側のルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
