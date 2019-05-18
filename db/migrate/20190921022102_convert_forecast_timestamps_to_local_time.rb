class ConvertForecastTimestampsToLocalTime < ActiveRecord::Migration[6.0]
  def up
    Subregion.all.each do |subregion|
      zone = ActiveSupport::TimeZone.new(subregion.timezone).tzinfo.identifier
      subregion.msws.unscope(:order, where: %w[timestamp updated_at]).update_all("timestamp = timestamp at time zone 'UTC' at time zone '#{zone}'")
    end
  end

  def down
    Subregion.all.each do |subregion|
      zone = ActiveSupport::TimeZone.new(subregion.timezone).tzinfo.identifier
      subregion.msws.unscope(:order, where: %w[timestamp updated_at]).update_all("timestamp = timestamp at time zone '#{zone}' at time zone 'UTC'")
    end
  end
end
