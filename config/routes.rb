Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users,
    :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' },
    :skip => [:sessions]

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root 'main#index'
  get 'leaderboard', to: 'main#leaderboard'
  get 'profile', to: 'users#edit'

  resources :users, only: [:edit, :update]
  resources :cohorts, except: [:destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
