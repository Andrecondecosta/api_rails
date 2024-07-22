Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :photos
      resources :articles
      resources :category_photos, only: [:create, :destroy, :index]
      resources :contacts
    end
  end

  # Define a rota para a verificação de saúde
  get "up" => "rails/health#show", as: :rails_health_check

  # Rota para redirecionar todas as requisições não reconhecidas para o frontend
  get '*path', to: 'frontend#index', constraints: ->(req) { !req.xhr? && req.format.html? }

  # Define a rota raiz para servir o frontend
  root 'frontend#index'

   get '/callback', to: 'frontend#index'
end
