Rails.application.routes.draw do
 scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    resources :posts, only: [:index, :show, :edit, :new, :create, :update, :destroy] do
    end
  end
 # 顧客用
# URL /customers/sign_in ...
devise_for :user,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end
