Rails.application.routes.draw do

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about',to: 'homes#about'
    get 'customers/mypage',to: 'customers#show'
    get 'customers/unsubscribe',to: 'customers#unsubscribe'
    patch 'customers/withdraw',to: 'customers#withdraw'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    get '/items/genre/:genre_id' => 'items#genre_search', as: 'genre_search'
    get '/items/search' => 'items#search'
    delete 'cart_items/destroy_all' ,to: 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    post 'orders/confirm',to: 'orders#confirm'
    get 'orders/complete',to: 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

end
