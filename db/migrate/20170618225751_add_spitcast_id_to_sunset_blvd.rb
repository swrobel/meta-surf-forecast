class AddSpitcastIdToSunsetBlvd < ActiveRecord::Migration[5.1]
  def up
    Spot.find_by(surfline_id: 4883, msw_id: 3673).update_columns(spitcast_id: 387)
  end

  def down
    Spot.find_by(surfline_id: 4883, msw_id: 3673).update_columns(spitcast_id: nil)
  end
end
