# frozen_string_literal: true

class SpotsController < ApplicationController
  before_action :check_unlocked

  def show
    @timestamps = spot.unique_timestamps
  end

private

  def region
    @region ||= Region.find(params.expect(:region_id))
  end

  def subregion
    @subregion ||= region.subregions.find(params.expect(:subregion_id))
  end

  def spot
    @spot ||= subregion.spots.optimized.find(params.expect(:spot_id))
  end
end
