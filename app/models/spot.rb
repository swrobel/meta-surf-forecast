# frozen_string_literal: true
class Spot < ApplicationRecord
  has_many :surfline_nearshores
  has_many :surfline_lolas
  has_many :msws
  has_many :spitcasts

  default_scope -> { order(:name) }
  scope :optimized, -> { includes(:msws, :surfline_nearshores, :surfline_lolas, :spitcasts) }

  def map_url
    "https://www.google.com/maps/search/#{lat},#{lon}"
  end

  def unique_timestamps
    (msws.collect(&:timestamp) | surfline_nearshores.collect(&:timestamp) | surfline_lolas.collect(&:timestamp) | spitcasts.collect(&:timestamp)).sort
  end

  def overlapping_timestamps
    timestamps = msws.collect(&:timestamp)
    if surfline_id
      timestamps &= surfline_nearshores.collect(&:timestamp)
      timestamps &= surfline_lolas.collect(&:timestamp)
    end
    timestamps &= spitcasts.collect(&:timestamp) if spitcast_id
    timestamps.sort
  end
end
