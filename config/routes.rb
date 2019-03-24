Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :rooms do
    resources :tracks, only: [:index, :create]
  end
  resources :guests do
    resources :tracks, only: [:index]
  end
  resources :tracks
end
