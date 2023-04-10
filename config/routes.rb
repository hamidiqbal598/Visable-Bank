Rails.application.routes.draw do

  # API Routes
  namespace :api do
    namespace :v1 do
      resources :transactions
      resources :accounts, only: %i[index create destroy] do
        collection do
          get :balance
        end
      end
      resources :users
    end
  end
end
