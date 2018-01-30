Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#index"
  get 'about' => 'static#about', as: "about"
  get 'contact_us' => 'static#contact_us', as: "contact_us"
  get 'medical_news' => 'static#medical_news', as: "medical_news"
  get '/api/get-medical-news' => 'static#medical_news'

  resources :users, controller: "users", only: [:show, :edit, :update, :destroy]

  get "/sign_in" => "users#new", as: "sign_in"
  post "/log_in" => "users#create"
  get "/sign_up" => "sessions#new", as: "sign_up"
  post "/sign_up" => "sessions#create", as: "users"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get 'cities/:state', to: 'application#cities'

  post "/users/:id/verify" => "users#verify", as: "verify_user"

  post "/users/:id/unverify" => "users#unverify", as: "unverify_user"

  get "/search" => "users#search", as: "search"

  resources :questions do
    resources :answers, only: [:index, :create]
  end

  resources :answers, only: [:destroy]

end
