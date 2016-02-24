Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'shops/create'

  get 'organisations/create'

  get 'organisation_memberships/create'

  get 'memberships/create'

  get 'plannings/:planning_id/scheduler_test/test' => 'scheduler_test#test'
  post 'plannings/:planning_id/shifts/find_and_destroy' => 'shifts#find_and_destroy', as: :find_and_destroy

  devise_for :users
  root to: 'pages#home'
  resources :users, except: [:index, :create]
  post 'users_custom' => "users#create", as: :custom
  resources :postes, except: :index
  resources :memberships, only: :create
  resources :organisation_memberships, only: :create
  resources :organisations, only: :create
  resources :shops, only: :create do
    resources :plannings, only: [:new, :create, :index]
  end

  resources :plannings, only: [:show, :edit, :update, :destroy] do
    resources :shifts, only: [:create, :update, :destroy]
  end


  mount Attachinary::Engine => "/attachinary"
end
