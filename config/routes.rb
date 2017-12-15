Rails.application.routes.draw do

  get 'check_hotel', to: 'hotels#check_hotel'
  get 'wait_accept', to: 'hotels#wait_accept'


  devise_for :users
  resources :hotels
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
