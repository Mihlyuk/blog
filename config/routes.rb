Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end

  POST 'quiz', to: 'quiz#new'

  root 'welcome#index'
end
