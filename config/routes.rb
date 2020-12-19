Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  scope module: :logged_out do
      root to: 'home#welcome'
  end
 
  namespace :logged_in do
    root to: 'main#welcome'
  end

  #root to: 'logged_in/home#welcome'
end
