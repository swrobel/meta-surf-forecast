class MigrateSurflineIdsFromV1ToV2 < ActiveRecord::Migration[6.0]
  def up
    Spot.where.not(surfline_v1_id: nil).where(surfline_v2_id: nil).each do |spot|
      response = Typhoeus.get(spot.surfline_v1_url, followlocation: true)
      spot.update(surfline_v2_id: response.effective_url.split('/').last)
    end
  end
end
