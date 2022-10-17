Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "events#index"

  resources :events

  post '/events/register', to: 'events#register_toggle', as: 'event_register_toggle'
end
