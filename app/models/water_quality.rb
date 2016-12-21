# frozen_string_literal: true
class WaterQuality < ApplicationRecord
  extend ApiMethods

  belongs_to :dept, class_name: 'WaterQualityDepartment', foreign_key: :dept_id
end
