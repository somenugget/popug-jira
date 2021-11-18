Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    delete 'sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
    get 'sign_in', to: 'users/sessions#new', as: 'new_user_session'
  end
end
