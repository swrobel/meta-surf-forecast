# frozen_string_literal: true

namespace :msw do
  desc 'Update forecast from MagicSeaweed'
  task update: %w[environment forecasts:set_batch_id] do
    Rails.logger.info 'Updating MagicSeaweed data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: API_CONCURRENCY)

    Spot.where.not(msw_id: nil).each do |spot|
      ApiRequest.new(requestable: spot, service: Msw, hydra: hydra, typhoeus_opts: { cookie: "MSW_session=#{ENV['MSW_SESSION_ID']}" }).get
    end

    hydra.run

    Rails.logger.info 'Finished updating MagicSeaweed data'
  end
end
