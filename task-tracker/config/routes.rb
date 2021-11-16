Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
    get 'sign_in', to: 'users/sessions#new', as: 'new_user_session'
  end

  root 'tasks#index'

  resources :tasks do
    collection do
      get :my, to: 'tasks#index'
      put :reassign
    end

    member do
      put :complete
    end
  end
end
