Rails.application.routes.draw do
  scope :api do
    resources :heroes, only: [:index, :show] do
      resources :abilities, only: [:index]
    end
    resources :abilities, only: [:index, :show]
  end
end
