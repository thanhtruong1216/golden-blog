Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    root 'posts#index'
    devise_for :users, :controllers => { registrations: 'registrations' }

    resources :users do
      member do
        get :following, :followers
      end
      collection do
        get :search
      end
    end

    resources :posts do
      resources :comments
      member do
        post :like
        post :unlike
      end
    end

    resources :relationships,       only: [:create, :destroy]
  end
end
