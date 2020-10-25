# frozen_string_literal: true

class Spot < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :subregion

  include Spots::Msw
  include Spots::SpitcastV2
  include Spots::SurflineV1
  include Spots::SurflineV2
  include Timezones

  belongs_to :subregion

  scope :optimized, -> { includes(:msws, :spitcast_v2s, :surfline_nearshores, :surfline_lolas, :surfline_v2s) }
  scope :ordered, -> { order(:sort_order, :id) }

  delegate :timezone, to: :subregion

  class << self
    def map_url(lat, lon)
      "https://www.google.com/maps/search/#{lat},#{lon}"
    end
  end

  def map_url
    self.class.map_url(lat, lon)
  end

  memoize def overlapping_timestamps
    timestamps = msws.collect(&:timestamp)
    if surfline_v1_id
      timestamps &= surfline_nearshores.collect(&:timestamp)
      timestamps &= surfline_lolas.collect(&:timestamp)
    end
    timestamps &= surfline_v2s.collect(&:timestamp) if surfline_v2_id
    timestamps &= spitcast_v2s.collect(&:timestamp) if spitcast_id
    timestamps.sort
  end

  memoize def unique_timestamps
    (msws.collect(&:timestamp) | surfline_nearshores.collect(&:timestamp) | surfline_lolas.collect(&:timestamp) | surfline_v2s.collect(&:timestamp) | spitcast_v2s.collect(&:timestamp)).sort
  end
end
