# frozen_string_literal: true

class Spot < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :subregion

  has_many :surfline_nearshores, dependent: :delete_all
  has_many :surfline_lolas, dependent: :delete_all
  has_many :msws, dependent: :delete_all
  has_many :spitcasts, dependent: :delete_all
  belongs_to :subregion

  scope :optimized, -> { includes(:msws, :surfline_nearshores, :surfline_lolas, :spitcasts) }
  scope :ordered, -> { order(:sort_order, :id) }

  class << self
    def map_url(lat, lon)
      "https://www.google.com/maps/search/#{lat},#{lon}"
    end

    def msw_url(msw_slug, msw_id)
      "#{Msw.site_url}/#{msw_slug}-Surf-Report/#{msw_id}/"
    end

    def spitcast_url(spitcast_slug)
      "#{Spitcast.site_url}/surf-report/spot/#{spitcast_slug}/"
    end

    def surfline_url(surfline_id)
      "#{Surfline.site_url}/surfdata/report-c.cfm?id=#{surfline_id}"
    end
  end

  def map_url
    self.class.map_url(lat, lon)
  end

  def msw_url
    self.class.msw_url(msw_slug, msw_id)
  end

  def spitcast_url
    self.class.spitcast_url(spitcast_slug)
  end

  def surfline_url
    self.class.surfline_url(surfline_id)
  end

  def num_forecasts
    num = 0
    num += 2 if surfline_id
    num += 1 if msw_id
    num += 1 if spitcast_id
    num
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
