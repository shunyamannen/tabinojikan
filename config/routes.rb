Rails.application.routes.draw do
# ユーザー側
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :posts, only: [:index, :show, :edit, :new, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
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

  end
  
  
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end
