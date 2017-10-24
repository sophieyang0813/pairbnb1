Rails.application.routes.draw do
    root "statics#home"
  resources :passwords, controller: "passwords", only: [:create, :new, :edit]
  resources :listings, controller: "listings", only: [:create, :new, :edit]

  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password, controller: "passwords", only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/users/:user_id/password/edit" => "passwords#edit"

end
