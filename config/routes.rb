Rails.application.routes.draw do
  root 'events#show' # this is the entry point for the UI
  get '/date/:date', to: 'events#show'
  get '/dates', to: 'events#index'

  namespace :api do
    get 'event_dates', to: 'event_dates#index'
    get 'event_dates/:date', to: 'event_dates#show'
  end
end
