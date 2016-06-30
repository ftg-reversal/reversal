# == Route Map
#
#           Prefix Verb   URI Pattern                              Controller#Action
#             root GET    /                                        home#index
#            login GET    /login(.:format)                         login#index
#                  GET    /auth/:provider/callback(.:format)       sessions#create
#          session DELETE /session(.:format)                       sessions#destroy
#           videos GET    /videos(.:format)                        videos#index
#         channels GET    /channels(.:format)                      slack_channels#index
#          channel GET    /channels/:id(.:format)                  slack_channels#show
#            rlogs GET    /rlogs(.:format)                         rlogs#index
#            pages GET    /pages(.:format)                         pages#index
#                  POST   /pages(.:format)                         pages#create
#         new_page GET    /pages/new(.:format)                     pages#new
#        edit_page GET    /pages/:id/edit(.:format)                pages#edit
#             page GET    /pages/:id(.:format)                     pages#show
#                  PATCH  /pages/:id(.:format)                     pages#update
#                  PUT    /pages/:id(.:format)                     pages#update
#                  DELETE /pages/:id(.:format)                     pages#destroy
#        summaries GET    /summaries(.:format)                     summaries#index
#                  POST   /summaries(.:format)                     summaries#create
#      new_summary GET    /summaries/new(.:format)                 summaries#new
#     edit_summary GET    /summaries/:id/edit(.:format)            summaries#edit
#          summary GET    /summaries/:id(.:format)                 summaries#show
#                  PATCH  /summaries/:id(.:format)                 summaries#update
#                  PUT    /summaries/:id(.:format)                 summaries#update
#                  DELETE /summaries/:id(.:format)                 summaries#destroy
#   archived_event GET    /events/:id/archived(.:format)           events#archived
#           events GET    /events(.:format)                        events#index
#                  POST   /events(.:format)                        events#create
#        new_event GET    /events/new(.:format)                    events#new
#       edit_event GET    /events/:id/edit(.:format)               events#edit
#            event GET    /events/:id(.:format)                    events#show
#                  PATCH  /events/:id(.:format)                    events#update
#                  PUT    /events/:id(.:format)                    events#update
#                  DELETE /events/:id(.:format)                    events#destroy
#          entries POST   /entries(.:format)                       entries#create
#            entry DELETE /entries/:id(.:format)                   entries#destroy
#            users GET    /users(.:format)                         reversal_users#index
# participate_user GET    /user/:screen_name/participate(.:format) reversal_users#participate
#    activity_user GET    /user/:screen_name/activity(.:format)    reversal_users#activity
#        rlog_user GET    /user/:screen_name/rlog(.:format)        reversal_users#rlog
#       event_user GET    /user/:screen_name/event(.:format)       reversal_users#event
#                  GET    /user(.:format)                          reversal_users#index
#        edit_user GET    /user/:screen_name/edit(.:format)        reversal_users#edit
#             user GET    /user/:screen_name(.:format)             reversal_users#show
#                  PATCH  /user/:screen_name(.:format)             reversal_users#update
#                  PUT    /user/:screen_name(.:format)             reversal_users#update
#                  GET    /chara/:chara_id/videos(.:format)        charas#video
#     api_channels GET    /api/channels(.:format)                  api/channels#index {:format=>/json/}
#      api_channel GET    /api/channels/:id(.:format)              api/channels#show {:format=>/json/}
#         ckeditor        /ckeditor                                Ckeditor::Engine
#
# Routes for Ckeditor::Engine:
#         pictures GET    /pictures(.:format)             ckeditor/pictures#index
#                  POST   /pictures(.:format)             ckeditor/pictures#create
#          picture DELETE /pictures/:id(.:format)         ckeditor/pictures#destroy
# attachment_files GET    /attachment_files(.:format)     ckeditor/attachment_files#index
#                  POST   /attachment_files(.:format)     ckeditor/attachment_files#create
#  attachment_file DELETE /attachment_files/:id(.:format) ckeditor/attachment_files#destroy
#

Rails.application.routes.draw do
  # Home
  root to: 'home#index'

  # Login
  get '/login', to: 'login#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  resource :session, only: [:destroy]

  resources :videos, only: [:index]
  resources :slack_channels, as: :channels, path: :channels, only: [:index, :show]
  resources :rlogs, only: [:index]
  resources :pages
  resources :summaries

  # Event
  resources :events do
    member do
      get :archived
    end
  end
  resources :entries, only: [:create, :destroy]

  resources :reversal_users, path: :users, as: :users, only: [:index]
  resources :reversal_users, path: :user, param: 'screen_name', as: :users, only: [:index, :show, :edit, :update] do
    member do
      get :participate
      get :activity
      get :rlog
      get :event
    end
  end

  get '/chara/:chara_id/videos', to: 'charas#video'

  namespace :api, format: 'json' do
    resources :channels, only: [:index, :show]
  end

  mount Ckeditor::Engine => '/ckeditor'
end
