Rails.application.routes.draw do
  resources :chapters
  resources :books do
    resource :epub, only: [:show, :create]
  end
end
