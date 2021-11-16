Rails.application.routes.draw do
  root 'welcome#index'

  use_doorkeeper

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users do
    collection do
      get :current
    end
  end
end
