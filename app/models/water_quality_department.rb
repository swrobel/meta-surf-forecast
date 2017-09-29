# frozen_string_literal: true

class WaterQualityDepartment < ApplicationRecord
  has_many :water_qualities, dependent: :delete_all
end
