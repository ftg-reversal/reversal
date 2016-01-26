# == Route Map
#
# Prefix Verb URI Pattern Controller#Action
#   root GET  /           videos#index
#

Rails.application.routes.draw do
  root to: 'top#index'

  get '/videos', to: 'videos#index'

  get '/slack', to: 'slack#index'
  get '/slack/show/:channel', to: 'slack#show'

  # get '@:name', to: 'slack#users', as: 'user'
  get 'image', to: 'proxies#show', as: 'image_proxy'
end
