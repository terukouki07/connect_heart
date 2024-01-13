Rails.application.routes.draw do
  #会員側のルーティング
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #ゲストログイン
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'search' => 'searches#search'
    resources :chats, only: [:create, :show]
    resources :genres, only: [:show]

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :index, :destroy]
    end

    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get 'favorite'
      end
    end

  end

  #管理者側のルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
