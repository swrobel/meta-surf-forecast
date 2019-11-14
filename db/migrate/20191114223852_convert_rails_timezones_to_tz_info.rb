class ConvertRailsTimezonesToTzInfo < ActiveRecord::Migration[6.0]
  def up
    Subregion.all.each do |subregion|
      zone_id = ActiveSupport::TimeZone.new(subregion.timezone).tzinfo.identifier
      subregion.update!(timezone: zone_id)
    end
  end
end
