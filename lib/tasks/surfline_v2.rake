# frozen_string_literal: true

namespace :surfline_v2 do
  desc 'Update forecast from Surfline v2 API'
  task update: %w[environment forecasts:set_batch_id] do
    Rails.logger.info 'Updating Surfline v2 data...'

    hydra = Typhoeus::Hydra.new(max_concurrency: API_CONCURRENCY)

    Spot.where.not(surfline_v2_id: nil).each do |spot|
      ApiRequest.new(requestable: spot, service: SurflineV2, hydra: hydra).get
    end

    hydra.run

    Rails.logger.info 'Finished updating Surfline v2 data'
  end
end
