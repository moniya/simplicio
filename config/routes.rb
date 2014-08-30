

Simplicio::Application.routes.draw do
  post "uploadimage" => UploadImage

  get "notifications/index" , as: 'notifications'

  mount RailsAdmin::Engine => '/tierradelfuego615156', :as => 'rails_admin'

  devise_for :users

  root :to => "questions#index"
  get "search" => 'search#index', :as => 'search'
  get 'users/:id' => 'users#show', :as => 'user', :constraints => {:id => /\d+/}

  resource :profile

  resources :activities do
    get :more, on: :collection
  end

  resources :relationships do
    delete :remove, on: :collection
  end

  resources :comments

  resources :questions do
    get :more, on: :collection
    resources :votes
  end

  resources :answers do
    resources :votes
  end

  resources :questions do
    resources :answers
  end

  resources :answers do
    resources :comments
  end
end
