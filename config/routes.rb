Rails.application.routes.draw do
   # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
  }

namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :genres
    resources :customers
    resources :orders
    resources :order_details
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => "homes#about"
    resources :addresses
    resources :orders do
      post 'order/confirm' => 'orders#confirm'
      get 'orders/complete' => 'orders#complete'
    end
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      delete 'cart_items/all_destroy' => 'cart_items#all_destroy'
    end
    resources :items
    get 'customers/mypage' => 'customers#show'
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' =>  'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
  end
  
end
