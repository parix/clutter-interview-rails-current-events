Rails.application.routes.draw do
  root 'events#index' # this is the entry point for the UI
  get '/:date', to: 'events#show'

  namespace :api do
    get 'event_dates', to: 'event_dates#index'
    get 'event_dates/:date', to: 'event_dates#show'
  end
end
