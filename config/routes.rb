Rails.application.routes.draw do
  root to: 'courses#index'

  resources :courses
  resources :instructors
end
