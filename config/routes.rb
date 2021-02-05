Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  scope module: :logged_out do
      root to: 'home#welcome'
  end
  
 
  namespace :logged_in do
    root to: 'main#welcome'
    resources :books do
      member do
        get :download
      end
      delete :destroy_all, on: :collection
    end
    resources  :notes do
      member do
        get :download
      end
      #get :download_global
      get :download_global, on: :collection
      get :download_all, on: :collection
      delete :destroy_global, on: :collection
      delete :destroy_all, on: :collection

    end
  end
  #get '/logged_in/notes/download_global', to: 'logged_in/notes#global'

  match '*path', to: redirect('/'), via: :all

end
