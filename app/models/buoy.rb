class Buoy < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :region

  belongs_to :region
  has_many :buoy_reports

  scope :ordered, -> { order(:sort_order, :lat, :lon, :id) }

  def buoy_report_api_url
    "https://www.ndbc.noaa.gov/data/5day2/#{ndbc_id}_5day.spec"
  end
end
