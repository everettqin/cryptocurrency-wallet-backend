require 'sidekiq/web'


Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope defaults: {format: :json} do
    resources :users
    resources :transactions, only: [:index, :create, :show]
  end


  mount Sidekiq::Web => '/sidekiq'

end
