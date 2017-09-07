# frozen_string_literal: true

class Subregion < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  has_many :spots
end
