Rails.application.routes.draw do

  root 'home#show'

  get  '/dashboard', to: 'dashboard#show'

  get '/auth/github', as: :login
  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
