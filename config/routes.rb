Rails.application.routes.draw do
  root to: 'top#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  resource :session, only: [:destroy]

  resources :videos, only: [:index]
  resources :slack_channels, as: :channels, path: :channels, only: [:index, :show]
  resources :summaries

  namespace :api, { format: 'json' } do
    resources :channels, as: :channels, path: :channels, only: [:index, :show]
  end

  get '@:name', to: 'slack_channels#users', as: 'user'
  get 'image', to: 'proxies#show', as: 'image_proxy'
end
