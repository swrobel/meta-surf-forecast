# frozen_string_literal: true
class Spot < ApplicationRecord
  has_many :surfline_nearshores
  has_many :surfline_lolas
  has_many :msws
  has_many :spitcasts

  def map_url
    "https://www.google.com/maps/search/#{lat},#{lon}"
  end
end
