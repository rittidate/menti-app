Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations", sessions: "sessions" }
  
  devise_scope :user do
    get '/users/detail',  to: 'registrations#detail'
    put '/users/detail',  to: 'registrations#detail_update'
  end

  root 'home#index'
  get   '/terms',          to:  'home#terms'

  

  resources :users

  get '/users/:id/payment', to: 'users#payment', as: :users_payment
  put '/users/:id/payment', to: 'users#transaction', as: :users_transaction

  get '/dashboard',       to: 'dashboard#index'

  get '/settings',            to: 'settings#index'
  put '/settings',            to: 'settings#update'
  get '/settings/password',   to: 'settings#password', as: :settings_password
  put '/settings/password',   to: 'settings#change_password'
  get '/settings/payment',    to: 'settings#payment', as: :settings_payment
  put '/settings/payment',    to: 'payment#set_default'
  get '/settings/payment/new',to: 'settings#add_payment', as: :settings_add_payment
  get '/settings/category',   to: 'settings#category'
  get '/settings/mentor',   to: 'settings#mentor'
  put '/settings/mentor',   to: 'settings#mentor_create'
  put '/settings/mentor/detail',   to: 'settings#mentor_detail'
  put '/settings/mentor/update',   to: 'settings#mentor_update'


  get  '/payment',        to: 'payment#new', as: :new_payment
  post '/payment/:id/set_default', to: 'payment#set_default', as: :set_default_payment
  post '/payment',        to: 'payment#create'
  delete '/payment/:id',  to: 'payment#destroy', as: :destroy_payment


  put '/category/create_relation', to: 'category#create_category_user_relation'
  put '/category/delete_relation', to: 'category#delete_category_user_relation'
  put '/category/update_current', to: 'category#update_current'
  put '/category/update_desire', to: 'category#update_desire'
  put '/category/update_desire', to: 'category#update_desire'
  put '/category/relation', to: 'category#relation'
  put '/category/relation_one', to: 'category#relation_one'

  put '/feed_message',    to: 'feed_message#create'

  put '/follow',    to: 'follow#create'
  put '/follow/delete',    to: 'follow#delete'
end
