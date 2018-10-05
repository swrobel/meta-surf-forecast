# frozen_string_literal: true

class Region < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  has_many :subregions, -> { ordered }, dependent: :destroy

  scope :ordered, -> { order(:sort_order, :id) }
end
