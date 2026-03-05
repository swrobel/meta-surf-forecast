# frozen_string_literal: true

class Spot < ApplicationRecord
  extend FriendlyId

  friendly_id :sluggable, use: %i[slugged finders scoped], scope: :subregion

  include Spots::SpitcastV2
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

  # NOTE: Strip apostrophes
  # ex: Queen's becomes queens instead of queen-s
  def sluggable
    name.gsub(/[`'’]/o, '').strip
  end

private

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
