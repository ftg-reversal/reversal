Rails.application.routes.draw do
  get 'chara/video'

  # Home
  root to: 'home#index'

  # Login
  get '/login', to: 'login#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  resource :session, only: [:destroy]

  resources :videos, only: [:index]
  resources :slack_channels, as: :channels, path: :channels, only: [:index, :show]
  resources :summaries
  resources :pages

  # Event
  get '/events/archived', to: 'events#archived'
  resources :events
  resources :entries, only: [:create, :destroy]


  get '/chara/:chara_id/videos', to: 'charas#video'

  namespace :api, format: 'json' do
    resources :channels, only: [:index, :show]
  end

  # get '@:name', to: 'slack_channels#users', as: 'user', param: 'name'
  # get 'image', to: 'proxies#show', as: 'image_proxy'

  mount Ckeditor::Engine => '/ckeditor'
end
