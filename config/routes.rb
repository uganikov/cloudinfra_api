Rails.application.routes.draw do
  resources :instances
  resources :users, only: [ :create ] do
    collection do
      post 'login'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
