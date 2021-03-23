Rails.application.routes.draw do
  devise_for :users
  
  resources :quotes
  resources :leads
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Authenticates Blazer Using Devise
  authenticate :user, ->(user) { user.superadmin_role? or user.employee_role? } do
    mount Blazer::Engine, at: "blazer"
  end

  # # If Above Doesn't Work Then Uncomment Below:
  # mount Blazer::Engine, at: "blazer"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  get "residential" => "pages#residential"
  get "commercial" => "pages#commercial"
  get "quotes" => "pages#quote"

  get "/index" => "pages#index"

  #get 'welcome' => 'watson#welcome'

  get '/watson/update' => 'watson#speak'
  
  # /quotes is the action from the form in quote.html.erb
  post "/quotes" => "quotes#create"

  # /leads is the action from the form in index.html.erb
  post "/leads" => "leads#create"

end
