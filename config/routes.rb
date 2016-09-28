Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions" }
  
  devise_scope :user do
    get '/users/detail',  to: 'registrations#detail'
    put '/users/detail',  to: 'registrations#detail_update'
  end

  root 'home#index'
  get   '/terms',          to:  'home#terms'

  resources :users

  get '/dashboard',       to: 'dashboard#index'
end
