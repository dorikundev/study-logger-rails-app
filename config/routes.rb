Rails.application.routes.draw do
  get 'study_sessions/index'
  get 'study_sessions/show'
  get 'study_sessions/new'
  get 'study_sessions/create'
  get 'study_sessions/edit'
  get 'study_sessions/update'
  get 'study_sessions/destroy'
  get 'study_subjects/index'
  get 'study_subjects/new'
  get 'study_subjects/create'
  get 'study_subjects/edit'
  get 'study_subjects/update'
  get 'study_subjects/destroy'
  get 'home/index'
  
  # OmniAuth
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'  # POSTメソッドも受け付ける
  get '/auth/failure', to: 'sessions#failure'
  
  # ログアウト
  delete '/logout', to: 'sessions#destroy'

  # ホーム画面をルートに設定
  root "home#index"

  resources :study_subjects do
    member do
      patch :archive
      patch :unarchive
    end
  end

  # 科目管理のリソース
  resources :study_subjects
  # 学習記録のリソース
  resources :study_sessions
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
