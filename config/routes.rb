Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end

  resources :logs

  post 'quiz', to: 'quiz#solver'

  root 'welcome#index'
end
