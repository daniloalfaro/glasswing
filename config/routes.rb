# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pizzas#index'

  devise_for :users

  resources :users do
    resources :pizzas
  end
end
