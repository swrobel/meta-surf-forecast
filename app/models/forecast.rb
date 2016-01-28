class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :spot

  scope :current, -> {where("? < timestamp", Time.now)}
  scope :ordered, -> {order(:spot_id, :timestamp)}

  default_scope { current.ordered }
end
