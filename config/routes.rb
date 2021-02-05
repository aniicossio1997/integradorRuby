Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  scope module: :logged_out do
      root to: 'home#welcome'
  end
  
 
  namespace :logged_in do
    root to: 'main#welcome'
    resources :books
    resources  :notes
  end
  match '*path', to: redirect('/'), via: :all

end
