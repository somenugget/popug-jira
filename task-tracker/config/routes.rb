Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
  end

  root 'welcome#index'
end
