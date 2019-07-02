Fsmc::Application.routes.draw do

  root to: "viewings#index"

  match "/about", to: "static_pages#about", via: 'get'
  match "/links", to: "static_pages#links", via: 'get'
  match "/archive", to: "static_pages#archive", via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  resources :viewings, only: [:index]
  resources :movies do
    get 'search', on: :collection
    get 'all_by_rating', on: :collection
    get 'all_by_title', on: :collection
    get 'all_by_year', on: :collection
    get 'by_rating', on: :collection
    get 'by_title', on: :collection
    get 'all_no_viewing', on: :collection
  end

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
