Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end

  post "/quiz", to: "quiz#answer"

  root 'welcome#index'
end
