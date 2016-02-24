Rails.application.routes.draw do
  get 'shops/create'

  get 'organisations/create'

  get 'organisation_memberships/create'

  get 'memberships/create'

  get 'plannings/:planning_id/scheduler_test/test' => 'scheduler_test#test'

  devise_for :users
  root to: 'pages#home'
  resources :users, except: :index
  resources :plannings, except: :index do
    resources :shifts, only: [:create, :update, :destroy]
  end
  resources :postes, except: :index
  resources :memberships, only: :create
  resources :organisation_memberships, only: :create
  resources :organisations, only: :create
  resources :shops, only: :create
  get "shops/:shop_id/plannings" => 'plannings#index', as: :planning_index

  mount Attachinary::Engine => "/attachinary"
end
