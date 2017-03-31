# frozen_string_literal: true

# Serve websocket cable requests in-process
# mount ActionCable.server => '/cable'

Rails.application.routes.draw do
  constraints(host: /.herokuapp.com/) do
    get '/(*path)' => redirect { |_params, req| "https://#{ENV['DOMAIN']}#{req.fullpath}" } if ENV['HOST'].present?
  end

  resources :spots, only: [:index, :show]

  root to: 'spots#index'
end
