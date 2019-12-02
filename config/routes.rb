class ReservedWordConstraint
  def self.matches?(request)
    !RESERVED_WORDS.include? request.params[:region_id]
  end
end

Rails.application.routes.draw do
  get "/#{ENV['UNLOCK_KEY']}", to: 'application#unlock' if ENV['UNLOCK_KEY'].present?

  get '/regions/:id', to: redirect('/california/%{id}')
  constraints(ReservedWordConstraint) do
    get '/:region_id/:subregion_id', to: 'subregions#show', as: 'subregion'
    get '/:region_id/:subregion_id/:spot_id', to: 'spots#show', as: 'spot'
  end

  root to: redirect('/california/los-angeles')
end
