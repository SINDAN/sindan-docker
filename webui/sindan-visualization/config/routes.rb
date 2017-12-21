Rails.application.routes.draw do
  root to: 'log_campaigns#index'

  devise_for :users, only: [ :session ]

  resources :diagnosis_logs
  resources :log_campaigns do
    collection do
      get :search
    end
    member do
      get :all
      get :log
      get :error
    end
  end

  resources :statuses, path: "status", only: [ :index ]

  resources :ignore_error_results

  get 'about', to: 'static_pages#about'
end
