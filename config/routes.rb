Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  scope :api do
    resources :heroes, only: [:index, :show] do
      resources :abilities, only: [:index]
    end
    resources :abilities, only: [:index, :show]
  end
end
