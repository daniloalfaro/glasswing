# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'welcome#index'

  resources :users do
    resources :pizzas
    resources :orders
    resources :branches, only: [:index]

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
