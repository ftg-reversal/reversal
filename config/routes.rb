# == Route Map
#
# Prefix Verb URI Pattern Controller#Action
#   root GET  /           videos#index
#

Rails.application.routes.draw do
  root to: 'top#index'

  get '/videos' => 'videos#index'
end
