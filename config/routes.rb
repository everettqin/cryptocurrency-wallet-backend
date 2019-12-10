require 'sidekiq/web'


Rails.application.routes.draw do
  mount_devise_token_auth_for 'Administrator', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope defaults: {format: :json} do
    resources :users do
      collection do
        get :validate_email
      end
    end
    resources :transactions, only: [:index, :create, :show]
  end


  mount Sidekiq::Web => '/sidekiq'

end
