Rails.application.routes.draw do
  resources :lessons
  resources :enrollments
  devise_for :users

  resources :courses do
    resources :lessons
    resources :enrollments, only: %i[new create]
  end
  resources :users, only: %i[index show edit update]

  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'home/index'
  get 'home/activity'

  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
