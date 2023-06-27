Rails.application.routes.draw do

  # 管理者ログイン
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー登録/ログイン
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲストログイン
  devise_scope :user do
    post '/users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  # 管理者側
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end

    resources :users, only: [:index, :show, :edit, :update]
    get "search" => "searches#search"
  end


  # ユーザー側
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :posts, only: [:index, :show, :edit, :new, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => "users#withdraw", as: 'withdraw'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
      collection do
        get 'search'
      end
    end


    get "search" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end