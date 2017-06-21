Rails.application.routes.draw do
  root "static_pages#index"

  devise_for :users, controllers: { registrations: :registrations }
  resources :dishes, only: %i(create index new)

  resources :orders, only: %i(create new) do
    get :history, on: :collection
  end

  resources :users, only: %i(edit update) do
    get :list, on: :collection
  end

  namespace :api do
    namespace :v1 do
      get "today_orders/" => "api#today_orders", as: :today_orders
    end
  end
end
