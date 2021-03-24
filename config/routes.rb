Rails.application.routes.draw do
  devise_for :users
  
  resources :quotes
  resources :leads
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Authenticates user Using Devise
  authenticate :user, ->(user) { user.superadmin_role? or user.employee_role? } do
    get "interventions" => "interventions#interventions"
    mount Blazer::Engine, at: "blazer"
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  get "residential" => "pages#residential"
  get "commercial" => "pages#commercial"
  get "quotes" => "pages#quote"
  get "/index" => "pages#index"
  get '/watson/update' => 'watson#speak'
  
  # /quotes is the action from the form in quote.html.erb
  post "/quotes" => "quotes#create"

  # /leads is the action from the form in index.html.erb
  post "/leads" => "leads#create"

  # /intervention is the action from the form in intervention.html.erb
  post "/interventions" => "interventions#create"

  # /intervention is 
  get '/intervention/GetData' => 'interventions#interventionGetData'

end
