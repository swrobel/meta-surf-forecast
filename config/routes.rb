# frozen_string_literal: true
Rails.application.routes.draw do
  constraints(host: /.herokuapp.com/) do
    get '/(*path)' => redirect { |_params, req| "https://#{ENV['HOST']}#{req.fullpath}" } if ENV['HOST'].present?
  end

  resources :spots
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root to: 'spots#index'
end
