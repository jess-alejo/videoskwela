Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :lessons
  resources :enrollments do
    collection do
      get :students
    end
  end

  namespace :analytics do
    get :users_per_day
    get :enrollments_per_day
    get :course_popularity
    get :money_makers
  end

  resources :courses, except: :edit do
    collection do
      get :enrolled
      get :pending_review
      get :authored
      get :pending_approval
    end
    member do
      patch :publish
      patch :review
      patch :approve
      get :analytics
    end
    resources :lessons do
      resources :comments, only: %i[create destroy]
      put :sort
      member do
        delete :remove_video
        delete :remove_video_thumbnail
      end
    end
    resources :enrollments, only: %i[new create]
    # resources :course_wizard, module: 'courses'
    resources :course_wizard, controller: 'courses/course_wizard'
  end

  resources :users, only: %i[index show edit update]
  resources :youtube, only: :show
  resources :tags, only: %i[index create destroy]

  get 'privacy_policy', to: 'home#privacy_policy'
  get 'activity',       to: 'home#activity'
  get 'analytics',      to: 'home#analytics'

  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
