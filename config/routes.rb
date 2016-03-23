Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'plannings/:id/week' => 'plannings#week_view', as: :week_view
  post 'plannings/:planning_id/shifts/find_and_destroy' => 'shifts#find_and_destroy', as: :find_and_destroy
  post 'plannings/:planning_id/shifts/find_and_update' => 'shifts#find_and_update', as: :find_and_update
  patch 'plannings/:id/declare' => 'plannings#declare', as: :declare
  get 'plannings/:id/export' => 'plannings#export', as: :export
  patch 'shops/:shop_id/users/:user_id/archive_user' => 'memberships#archive_user', as: :archive_user
  patch 'shops/:shop_id/users/:user_id/retrieve_user' => 'memberships#retrieve_user', as: :retrieve_user

  get 'groups/:id/admin' => 'groups#admin_space', as: :admin_space
  get 'groups/:id/plannings' => 'groups#plannings', as: :group_plannings

  get 'profile' => 'profile#showProfileData'
  devise_for :users
  root to: 'pages#home'
  resources :users, except: [:index, :create]
  post 'users_custom' => "users#create", as: :custom
  resources :postes, except: :index
  resources :memberships, only: :create
  resources :organisation_memberships, only: :create
  resources :organisations, only: :create do
    resources :groups, only: :index
  end
  resources :shops, only: :create do
    resources :plannings, only: [:new, :create, :index]
    get '/users/total' => 'users#total', as: :total
    get '/users/archives' => 'users#archives', as: :archived_users
    patch '/users/:id/destroy_contract' => 'users#destroy_contract', as: :destroy_contract
  end

  resources :plannings, only: [:show, :edit, :update, :destroy] do
    resources :shifts, only: [:create, :update, :destroy]
  end


  mount Attachinary::Engine => "/attachinary"
end
