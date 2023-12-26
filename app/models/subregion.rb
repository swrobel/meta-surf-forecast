# frozen_string_literal: true

class Subregion < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :region

  belongs_to :region
  has_many :spots, -> { ordered }, dependent: :destroy
  has_many :msws, through: :spots
  has_many :spitcast_v1s, through: :spots
  has_many :spitcast_v2s, through: :spots
  has_many :surfline_lolas, through: :spots
  has_many :surfline_nearshores, through: :spots
  has_many :surfline_v2_lolas, through: :spots
  has_many :surfline_v2_lotus, through: :spots

  scope :ordered, -> { order(:sort_order, :id) }

private

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
