# frozen_string_literal: true

class Subregion < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders scoped], scope: :region

  belongs_to :region
  has_many :spots, -> { ordered }, dependent: :destroy

  scope :ordered, -> { order(:sort_order, :id) }
end
