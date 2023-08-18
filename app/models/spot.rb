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

  scope :optimized, -> { includes(:spitcast_v2s, :surfline_v2_lotus) }
  scope :ordered, -> { order(:sort_order, :id) }

  delegate :timezone, to: :subregion

  memoize def overlapping_timestamps
    timestamps = surfline_v2_lotus.collect(&:timestamp)
    timestamps &= spitcast_v2s.collect(&:timestamp) if spitcast_id
    timestamps.sort
  end

  memoize def unique_timestamps
    (surfline_v2_lotus.collect(&:timestamp) | spitcast_v2s.collect(&:timestamp)).sort
  end
end
