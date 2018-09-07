Rails.application.routes.draw do
  devise_for :users
  root 'projects#index'

  resources :attachments, only: [:show, :new]

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        get :search
      end
      member do
        post :watch
      end
    end
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
    resources :tags, only: [] do
      member do
        delete :remove
      end
    end
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
