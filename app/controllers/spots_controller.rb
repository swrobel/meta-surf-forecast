# frozen_string_literal: true

class SpotsController < ApplicationController
  def show
    @timestamps = spot.unique_timestamps
  end

private

  def region
    @region ||= Region.find(params[:region_id])
  end

  def subregion
    @subregion ||= region.subregions.find(params[:subregion_id])
  end

  def spot
    @spot ||= subregion.spots.optimized.find(params[:spot_id])
  end
end
