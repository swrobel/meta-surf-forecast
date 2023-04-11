# frozen_string_literal: true

class SubregionsController < ApplicationController
  before_action :check_unlocked

  FLOAT_FIELDS = %i[max min avg_delta max_delta].freeze

  def show
    forecasts ||= Spot.connection.select_all <<-SQL.squish
      SELECT *
      FROM consolidated_forecasts
      WHERE subregion_id = #{subregion.id}
    SQL
    @max = 0.0
    forecasts.each(&:symbolize_keys!)
    forecasts.each do |forecast|
      forecast[:xaxis_time] = helpers.format_timestamp(forecast[:timestamp])
      forecast[:tooltip_time] = forecast[:timestamp].strftime('%a %-m/%-e %-l%P')
      FLOAT_FIELDS.each do |field|
        forecast[field] = forecast[field].to_f
      end
      @max = [forecast[:max], @max].max
      forecast[:avg_rating] = forecast[:avg_rating].to_i
    end
    @spots = forecasts.group_by do |s|
      { spot_id: s[:spot_id],
        name: s[:name],
        slug: s[:slug],
        lat: s[:lat],
        lon: s[:lon],
        msw_id: s[:msw_id],
        spitcast_id: s[:spitcast_id],
        spitcast_slug: s[:spitcast_slug],
        surfline_v1_id: s[:surfline_v1_id],
        surfline_v2_id: s[:surfline_v2_id],
        spot_updated_at: s[:spot_updated_at] }
    end
  end

private

  def region
    @region ||= Region.find(params[:region_id])
  end

  def subregion
    @subregion ||= region.subregions.find(params[:subregion_id])
  end
end
