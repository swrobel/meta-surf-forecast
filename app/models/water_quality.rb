# frozen_string_literal: true

class WaterQuality < ApplicationRecord
  belongs_to :dept, class_name: 'WaterQualityDepartment'
end
