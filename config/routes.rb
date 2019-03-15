Rails.application.routes.draw do
  resources :ripples, except: [:update, :destroy]

  root 'ripples#index'
  get 'page/:page', to: 'ripples#page', as: :ripples_page

  match '*path' => redirect('/'), via: :get
end
