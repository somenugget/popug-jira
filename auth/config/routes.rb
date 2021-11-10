Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users

  resources :users do
    collection do
      get :current
    end
  end
end
