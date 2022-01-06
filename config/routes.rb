Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :tasks
  end

  root 'categories#index'

  get 'toggle_task' => 'tasks#toggle_status'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
