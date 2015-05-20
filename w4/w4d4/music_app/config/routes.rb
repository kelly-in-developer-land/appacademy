Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:index, :new]
  end
  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:index, :new]
  end
  resources :tracks, except: [:index, :new] do
    resources :notes
  end
end
