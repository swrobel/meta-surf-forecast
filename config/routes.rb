class ReservedWordConstraint
  def self.matches?(request)
    RESERVED_WORDS.exclude?(request.params[:region_id])
  end
end

Rails.application.routes.draw do
  mount PgHero::Engine, at: 'pghero' if defined?(PgHero)

  get "/#{ENV.fetch('UNLOCK_KEY', nil)}", to: 'application#unlock' if ENV['UNLOCK_KEY'].present?

  get '/regions/:id', to: redirect('/southern-california/%{id}')
  get '/california/:id', to: redirect('/southern-california/%{id}')
  constraints(ReservedWordConstraint) do
    get '/:region_id/buoys', to: 'regions#buoys', as: 'buoys'
    get '/:region_id/:subregion_id', to: 'subregions#show', as: 'subregion'
    get '/:region_id/:subregion_id/:spot_id', to: 'spots#show', as: 'spot'
  end

  root to: 'application#root'
end
