Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/search', controller: :search, action: :query

  # Defines the root path route ("/")
  root 'welcome#index'
end
