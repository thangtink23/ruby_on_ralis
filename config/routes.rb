Rails.application.routes.draw do

  get 'check_hotel', to: 'hotels#check_hotel'
  get 'wait_accept', to: 'hotels#wait_accept'


  devise_for :users
get "user/:id", to: 'profiles#show', as: 'user_profile'
  post "avatar/:id", to: 'profiles#avatar', as: 'user_profile_avatar'
  get 'profile/change_password', to: 'profiles#change_password', as: "user_change_password"
  patch "profile/change_password", to: 'profiles#update_password', as: 'user_update_password'
  
  resources :hotels
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # bookmarks 
  get 'bookmarks', to: 'bookmarks#index'
  post 'bookmarks', to: 'bookmarks#create'
  delete 'bookmarks', to: 'bookmarks#destroy'

  root to: 'pages#home'

end
