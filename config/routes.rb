Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: "homes#top"
  get "/about" => "homes#about"

  resources :users, only: [ :show, :edit, :index, :update] do
    collection do
      get "my_page"     #ユーザーのマイページ
      get "unsubscribe" #退会画面の確認
      patch "withdraw"  #退会処理、論理削除
    end
  end

  resources :posts, except: [ :new ] do
    collection do
      get "ranking" #投稿とフォロワーの人気ランキング
    end
  end

  resources :comments, only: [ :create, :destroy ]
  resources :likes, only: [ :create, :destroy ]
  resources :relationships, only: [ :create, :destroy ]
  resources :bookmarks, only: [ :create, :destroy ]
  resources :notifications, only: [ :create, :index ]

end
