class RegionsController < ApplicationController
  FLOAT_FIELDS = %i[swell_wave_height ground_swell_height ground_swell_period ground_swell_direction wind_wave_height wind_swell_height wind_swell_period wind_swell_direction].freeze

  def buoys
    buoy_reports ||= Buoy.connection.select_all <<-SQL.squish
      SELECT
         b.ndbc_id
        ,b.name
        ,b.slug
        ,b.lat
        ,b.lon
        ,br.timestamp
        ,br.ground_swell_height * br.ground_swell_period * 0.1 as swell_wave_height
        ,br.ground_swell_height
        ,br.ground_swell_period
        ,br.ground_swell_direction
        ,br.wind_swell_height * br.wind_swell_period * 0.1 as wind_wave_height
        ,br.wind_swell_height
        ,br.wind_swell_period
        ,br.wind_swell_direction
      FROM buoy_reports br
      JOIN buoys b ON br.buoy_id = b.id
      JOIN regions r ON b.region_id = r.id
      WHERE b.region_id = #{region.id}
      AND timestamp >= now() at time zone '#{region.timezone}' - interval '1 day'
      ORDER BY b.lat desc, timestamp asc
    SQL
    buoy_reports.each(&:symbolize_keys!)
    buoy_reports.each do |buoy_report|
      buoy_report[:xaxis_time] = buoy_report[:timestamp].strftime('%-l:%M%P')[0..-2]
      buoy_report[:tooltip_time] = buoy_report[:timestamp].strftime('%a, %b %-e, %-l:%M %p')
      FLOAT_FIELDS.each do |field|
        buoy_report[field] = buoy_report[field].to_f
      end
    end
    @buoy_reports = buoy_reports.group_by do |b|
      { ndbc_id: b[:ndbc_id],
        name: b[:name],
        slug: b[:slug],
        lat: b[:lat],
        lon: b[:lon] }
    end
  end

private

  def region
    @region ||= Region.find(params[:region_id])
  end
end
