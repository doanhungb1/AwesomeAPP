Rails.application.routes.draw do
  devise_for :users

  resources :employees do
      member do
        get 'managers'
        get 'employees'
        get "relationship/:target_employee_id", to: "employees#relationship"
      end
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "profile#index"
  resources :profile, only: [:index, :new, :update, :create]
end
