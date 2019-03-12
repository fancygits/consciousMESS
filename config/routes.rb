Rails.application.routes.draw do
  resources :ripples, except: [:update, :destroy]

  root 'ripples#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
