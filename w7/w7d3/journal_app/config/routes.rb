Rails.application.routes.draw do
  get "/", to: "root#root"
  resources :posts
end
