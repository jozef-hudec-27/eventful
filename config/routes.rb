Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "events#index"

  resources :events

  post '/events/register', to: 'events#register_toggle', as: 'event_register_toggle'
  get '/events/:id/attendees', to: 'events#attendees', as: 'event_attendees'
  
  get '/users/:id/events', to: 'events#user_events', as: 'user_events'
  get '/users/attending-events', to: 'events#attending_events', as: 'user_attending_events'
end
