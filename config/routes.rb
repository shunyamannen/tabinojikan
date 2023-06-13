Rails.application.routes.draw do
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
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

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end
