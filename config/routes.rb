# frozen_string_literal: true
Rails.application.routes.draw do
  resources :spots
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root to: 'spots#index'
end
