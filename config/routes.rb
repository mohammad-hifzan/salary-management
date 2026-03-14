Rails.application.routes.draw do
  resources :employees do
    member do
      get :salary
    end
    collection do
      get :salary_metrics
    end
  end
end
