# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'orders/index'
  # get 'orders/show'
  # get 'orders/new'
  # get 'carts/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pizzas#index'

  devise_for :users

  resources :users do
    resources :pizzas
    resources :orders

    get 'carts/:id' => 'carts#show', as: 'cart'
    delete 'carts/:id' => 'carts#destroy'

    post 'line_items/:id/add' => 'line_items#add_quantity',
         as: 'line_item_add'
    post 'line_items/:id/reduce' => 'line_items#reduce_quantity',
         as: 'line_item_reduce'
    post 'line_items' => 'line_items#create'

    get 'line_items/:id' => 'line_items#show',
        as: 'line_item'

    delete 'line_items/:id' => 'line_items#destroy'
  end
end
