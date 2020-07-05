Rails.application.routes.draw do
  resources :meetings
  get '/attend_session', to: 'live_sessions#attend_session'
  post '/get_signature', to: 'live_sessions#get_signature'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
