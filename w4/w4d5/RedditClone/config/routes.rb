Rails.application.routes.draw do
  resources :users, only:[:new, :create, :show]
  resource :session, only:[:new, :create, :destroy]
  resources :subs, only:[:new, :create, :edit, :update, :show]
  resources :posts, only:[:new, :create, :edit, :update, :show] do
    resources :comments, only:[:new, :edit, :show]
  end
  resources :comments, only:[:create, :update]
end
