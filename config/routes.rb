# frozen_string_literal: true

Rails.application.routes.draw do
  constraints(host: /.herokuapp.com/) do
    get '/(*path)' => redirect { |_params, req| "https://#{ENV['DOMAIN']}#{req.fullpath}" } if ENV['HOST'].present?
  end

  resources :spots, only: :show
  resources :regions, only: :show

  root to: redirect('/regions/los-angeles')
end
