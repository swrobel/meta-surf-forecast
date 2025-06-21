class RenameSevenPointRatingToRating < ActiveRecord::Migration[8.0]
  def change
    rename_column :surfline_v2_lotus, :seven_point_rating, :rating
  end
end
