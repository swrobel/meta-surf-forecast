class AddSevenPointRatingToSurflineV2s < ActiveRecord::Migration[7.0]
  def change
    add_column :surfline_v2_lolas, :seven_point_rating, :integer
    add_column :surfline_v2_lotus, :seven_point_rating, :integer
  end
end
