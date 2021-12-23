Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/search', controller: :search, action: :query

  resource :resumes, only: [:new, :create]

  # Defines the root path route ("/")
  root 'welcome#index'
end
