Rails.application.routes.draw do
  resources :employees do
    member do
      get :salary
    end
  end
end
