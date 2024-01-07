Rails.application.routes.draw do
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :public do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'chats/show'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  #会員側のsign_id
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #管理者側のsign_in
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
