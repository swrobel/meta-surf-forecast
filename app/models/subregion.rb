# frozen_string_literal: true

class Subregion < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :region

  belongs_to :region
  has_many :spots, -> { ordered }, dependent: :destroy
  has_many :msws, through: :spots
  has_many :spitcasts, through: :spots
  has_many :surfline_lolas, through: :spots
  has_many :surfline_nearshores, through: :spots
  has_many :surfline_v2s, through: :spots

  scope :ordered, -> { order(:sort_order, :id) }
end
