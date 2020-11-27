Rails.application.routes.draw do
  get 'info/show'
  get 'info/settings'
  resources :tag_associations
  resources :tags
  resources :categories
  resources :tasks
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
