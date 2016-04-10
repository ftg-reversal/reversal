Rails.application.routes.draw do
  root to: 'top#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  resource :session, only: [:destroy]

  # resources :videos, only: [:index]
  # resources :slack_channels, as: :channels, path: :channels, only: [:index, :show]
  # resources :summaries
  # resources :pages
  resources :events do
    get 'entried'
  end

  resources :entries, only: [:create, :destroy]

  # namespace :api, { format: 'json' } do
  #   resources :channels, only: [:index, :show]
  # end

  # get '@:name', to: 'slack_channels#users', as: 'user', param: 'name'
  # get 'image', to: 'proxies#show', as: 'image_proxy'

  mount Ckeditor::Engine => '/ckeditor'
end
