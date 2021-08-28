Rails.application.routes.draw do
  devise_for :users

  resources :lessons
  resources :enrollments do
    collection do
      get :students
    end
  end

  resources :courses do
    collection do
      get :enrolled
      get :pending_review
      get :authored
    end
    resources :lessons
    resources :enrollments, only: %i[new create]
  end

  resources :users, only: %i[index show edit update]

  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'home/index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'

  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
