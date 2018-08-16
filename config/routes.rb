Rails.application.routes.draw do
  devise_for :users
  root 'projects#index'

  resources :attachments, only: [:show, :new]

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
  end

  namespace :admin do
    root 'application#index'

    resources :states, only: [:index, :new, :create] do
      member do
        patch :make_default
      end
    end
    resources :projects, only: [:new, :create, :destroy]
    resources :users do
      member do
        patch :archive
      end
    end
  end
end
