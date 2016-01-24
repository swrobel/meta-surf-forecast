class Spot < ApplicationRecord
  has_many :surflines
  has_many :msws
end
