class Buoy < ApplicationRecord
  include Timezones
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :region

  belongs_to :region
  has_many :reports, class_name: 'BuoyReport', dependent: :destroy

  scope :ordered, -> { order(:sort_order, :lat, :lon, :id) }

  delegate :timezone, to: :region

  def buoy_report_api_url
    "https://www.ndbc.noaa.gov/data/5day2/#{ndbc_id}_5day.spec"
  end
end
