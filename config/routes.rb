Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # bookmarks 
  get 'bookmarks', to: 'bookmarks#index'
  post 'bookmarks', to: 'bookmarks#create'
  delete 'bookmarks', to: 'bookmarks#destroy'

  root to: 'pages#home'

end
