# frozen_string_literal: true

Rails.application.routes.draw do
  constraints(host: /.herokuapp.com/) do
    get '/(*path)' => redirect { |_params, req| "https://#{ENV['DOMAIN']}#{req.fullpath}" } if ENV['HOST'].present?
  end

  get "/#{ENV['UNLOCK_KEY']}", to: 'application#unlock' if ENV['UNLOCK_KEY'].present?

  get '/regions/:id', to: redirect('/california/%{id}')
  get '/:region_id/:subregion_id', to: 'subregions#show', as: 'subregion'
  get '/:region_id/:subregion_id/:spot_id', to: 'spots#show', as: 'spot'

  root to: redirect('/california/los-angeles')
end
