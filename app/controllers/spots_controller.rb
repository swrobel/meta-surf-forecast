# frozen_string_literal: true

class SpotsController < ApplicationController
  before_action :set_spot

  def show
    @timestamps = @spot.unique_timestamps
  end

private

  def set_spot
    @spot = Spot.optimized.find(params[:id])
  end
end
