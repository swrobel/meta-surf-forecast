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

  scope :optimized, -> { includes(:msws, :spitcast_v2s, :surfline_nearshores, :surfline_lolas, :surfline_v2_lolas, :surfline_v2_lotus) }
  scope :ordered, -> { order(:sort_order, :id) }

  delegate :timezone, to: :subregion

  memoize def overlapping_timestamps
    timestamps = msws.collect(&:timestamp)
    if surfline_v1_id
      timestamps &= surfline_nearshores.collect(&:timestamp)
      timestamps &= surfline_lolas.collect(&:timestamp)
    end
    if surfline_v2_id
      timestamps &= surfline_v2_lolas.collect(&:timestamp)
      timestamps &= surfline_v2_lotus.collect(&:timestamp)
    end
    timestamps &= spitcast_v2s.collect(&:timestamp) if spitcast_id
    timestamps.sort
  end

  memoize def unique_timestamps
    (msws.collect(&:timestamp) | surfline_nearshores.collect(&:timestamp) | surfline_lolas.collect(&:timestamp) | surfline_v2_lolas.collect(&:timestamp) | surfline_v2_lotus.collect(&:timestamp) | spitcast_v2s.collect(&:timestamp)).sort
  end
end
