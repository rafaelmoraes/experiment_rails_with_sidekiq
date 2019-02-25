# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: %i[index create destroy] do
    patch :cancel, on: :member
  end
  post 'tasks/destroy_all', to: 'tasks#destroy_all'
  mount Sidekiq::Web => '/sidekiq'
end
