class Spot < ApplicationRecord
  has_many :surflines
  has_many :msws
  has_many :spitcasts
end
