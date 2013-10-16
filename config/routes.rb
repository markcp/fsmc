Fsmc::Application.routes.draw do
  match "/about", to: "static_pages#about", via: 'get'
  match "/links", to: "static_pages#links", via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  resources :viewings, only: [:index]
  resources :movies do
    get 'search', on: :collection
  end

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
