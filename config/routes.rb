Rails.application.routes.draw do
  get 'quiz/solver'

  resources :articles do
    resources :comments
  end

  post 'quiz', to: 'quiz#solver'

  root 'welcome#index'
end
