Rails.application.routes.draw do
  resources :instances
  delete 'instances', action: :destroy_all, controller: 'instances'
  resources :users, only: [ :create ] do
    collection do
      post 'login'
    end
  end
  get :user, action: :index, controller: 'users'
  get 'user/identity', action: :identity, controller: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
