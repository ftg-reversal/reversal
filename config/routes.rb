# == Route Map
#
#           Prefix Verb   URI Pattern                              Controller#Action
#             root GET    /                                        home#index
#            about GET    /about(.:format)                         home#about
#            login GET    /login(.:format)                         login#index
#                  GET    /auth/:provider/callback(.:format)       sessions#create
#          session DELETE /session(.:format)                       sessions#destroy
#    search_videos GET    /videos/search(.:format)                 videos#search
#   video_matchups POST   /videos/:video_id/matchups(.:format)     video_matchups#create
#       video_good GET    /videos/:video_id/good(.:format)         video/goods#show
#                  PATCH  /videos/:video_id/good(.:format)         video/goods#update
#                  PUT    /videos/:video_id/good(.:format)         video/goods#update
#                  DELETE /videos/:video_id/good(.:format)         video/goods#destroy
#           videos GET    /videos(.:format)                        videos#index
#            video GET    /videos/:id(.:format)                    videos#show
#    video_matchup DELETE /video_matchups/:id(.:format)            video_matchups#destroy
#  search_channels GET    /channels/search(.:format)               slack_channels#search
#         channels GET    /channels(.:format)                      slack_channels#index
#          channel GET    /channels/:id(.:format)                  slack_channels#show
#            rlogs GET    /rlogs(.:format)                         rlogs#index
#     search_pages GET    /pages/search(.:format)                  pages#search
#        page_good GET    /pages/:page_id/good(.:format)           page/goods#show
#                  PATCH  /pages/:page_id/good(.:format)           page/goods#update
#                  PUT    /pages/:page_id/good(.:format)           page/goods#update
#                  DELETE /pages/:page_id/good(.:format)           page/goods#destroy
#            pages GET    /pages(.:format)                         pages#index
#                  POST   /pages(.:format)                         pages#create
#         new_page GET    /pages/new(.:format)                     pages#new
#        edit_page GET    /pages/:id/edit(.:format)                pages#edit
#             page GET    /pages/:id(.:format)                     pages#show
#                  PATCH  /pages/:id(.:format)                     pages#update
#                  PUT    /pages/:id(.:format)                     pages#update
#                  DELETE /pages/:id(.:format)                     pages#destroy
# search_summaries GET    /summaries/search(.:format)              summaries#search
#     summary_good GET    /summaries/:summary_id/good(.:format)    summary/goods#show
#                  PATCH  /summaries/:summary_id/good(.:format)    summary/goods#update
#                  PUT    /summaries/:summary_id/good(.:format)    summary/goods#update
#                  DELETE /summaries/:summary_id/good(.:format)    summary/goods#destroy
#        summaries GET    /summaries(.:format)                     summaries#index
#                  POST   /summaries(.:format)                     summaries#create
#      new_summary GET    /summaries/new(.:format)                 summaries#new
#     edit_summary GET    /summaries/:id/edit(.:format)            summaries#edit
#          summary GET    /summaries/:id(.:format)                 summaries#show
#                  PATCH  /summaries/:id(.:format)                 summaries#update
#                  PUT    /summaries/:id(.:format)                 summaries#update
#                  DELETE /summaries/:id(.:format)                 summaries#destroy
#                  GET    /summaries/channel/:channel_id(.:format) summaries#new_summary_from_channel
#    search_events GET    /events/search(.:format)                 events#search
#       event_good GET    /events/:event_id/good(.:format)         event/goods#show
#                  PATCH  /events/:event_id/good(.:format)         event/goods#update
#                  PUT    /events/:event_id/good(.:format)         event/goods#update
#                  DELETE /events/:event_id/good(.:format)         event/goods#destroy
#           events GET    /events(.:format)                        events#index
#                  POST   /events(.:format)                        events#create
#        new_event GET    /events/new(.:format)                    events#new
#       edit_event GET    /events/:id/edit(.:format)               events#edit
#            event GET    /events/:id(.:format)                    events#show
#                  PATCH  /events/:id(.:format)                    events#update
#                  PUT    /events/:id(.:format)                    events#update
#                  DELETE /events/:id(.:format)                    events#destroy
#   archived_event GET    /event/archived(.:format)                events#archived
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
#      video_chara GET    /chara/:chara_name/video(.:format)       charas#video
#           search GET    /search(.:format)                        search#index
#     api_channels GET    /api/channels(.:format)                  api/channels#index {:format=>/json/}
#      api_channel GET    /api/channels/:id(.:format)              api/channels#show {:format=>/json/}
#          sitemap GET    /sitemap(.:format)                       redirect(301, https://s3-ap-northeast-1.amazonaws.com/reversal-sitemap/sitemaps/sitemap.xml.gz)
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
  get '/about', to: 'home#about'

  # Login
  get '/login', to: 'login#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  resource :session, only: [:destroy]

  resources :videos, only: [:index, :show] do
    collection do
      get :search
    end

    resources :video_matchups, as: :matchups, path: :matchups, only: [:create]
    resource :good, module: :video, only: [:show, :update, :destroy]
  end
  resources :video_matchups, only: [:destroy]

  resources :slack_channels, as: :channels, path: :channels, only: [:index, :show] do
    collection do
      get :search
    end
  end
  resources :rlogs, only: [:index]

  resources :pages do
    collection do
      get :search
    end

    resource :good, module: :page, only: [:show, :update, :destroy]
  end

  resources :summaries do
    collection do
      get :search
    end

    resource :good, module: :summary, only: [:show, :update, :destroy]
  end

  resource :summaries, only: [] do
    member do
      get 'channel/:channel_id', action: :new_summary_from_channel
    end
  end

  resources :events do
    collection do
      get :search
    end

    resource :good, module: :event, only: [:show, :update, :destroy]
  end

  resource :event, only: [] do
    member do
      get :archived
    end
  end

  resources :entries, only: [:create, :destroy]

  resources :reversal_users, path: :users, as: :users, only: [:index]
  resources :reversal_users, path: :user, param: :screen_name, as: :users, only: [:index, :show, :edit, :update] do
    member do
      get :participate
      get :activity
      get :rlog
      get :event
    end
  end

  resources :charas, path: :chara, param: :chara_name, only: [] do
    member do
      get :video
    end
  end

  get :search, controller: :search, action: :index

  namespace :api, format: 'json' do
    resources :channels, only: [:index, :show] do
      resources :messages, module: :channel, only: [:index]
    end
  end

  # sitemap
  get '/sitemap' => redirect('https://s3-ap-northeast-1.amazonaws.com/reversal-sitemap/sitemaps/sitemap.xml.gz')

  mount Ckeditor::Engine => '/ckeditor'
end
