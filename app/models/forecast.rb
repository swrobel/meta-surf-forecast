# frozen_string_literal: true

class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :api_request
  belongs_to :spot
  has_one :subregion, through: :spot

  scope :current, -> { joins(:subregion).where("timestamp >= now() at time zone subregions.timezone AND timestamp <= now() at time zone subregions.timezone + interval '1 month' AND #{table_name}.updated_at >= now() at time zone subregions.timezone - interval '1 day'") }
  scope :future, -> { joins(:subregion).where('timestamp > now() at time zone subregions.timezone') }
  scope :past, -> { joins(:subregion).where('timestamp < now() at time zone subregions.timezone') }
  scope :ordered, -> { order(:spot_id, :timestamp) }

  delegate :timezone, to: :spot

  def avg_height
    (min_height + max_height) / 2
  end

  class << self
    def default_scope
      current.ordered
    end

    def for_chart
      pluck('round(min_height, 1)', 'round(max_height, 1)')
    end

    def forecasted_max(stamps)
      [
        Spitcast.where(timestamp: stamps).maximum(:height),
        SurflineV2Lotus.where(timestamp: stamps).maximum(:max_height),
      ].map { |v| v || 0 }.max
    end

    delegate :parse, to: ::JSON
  end
end
