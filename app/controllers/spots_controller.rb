# frozen_string_literal: true
class SpotsController < ApplicationController
  before_action :set_spot, only: [:edit, :update, :destroy]

  # GET /spots
  # GET /spots.json
  def index
    @spots = Spot.optimized
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    @spot = Spot.optimized.find(params[:id])
    @timestamps = @spot.unique_timestamps
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit; end

  # POST /spots
  # POST /spots.json
  def create
    @spot = Spot.new(spot_params)

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'Spot was successfully created.' }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { render :new }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot, notice: 'Spot was successfully updated.' }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_spot
    @spot = Spot.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spot_params
    params.require(:spot).permit(:name, :lat, :lon, :surfline_id, :msw_id, :spitcast_id, :wunder_id)
  end
end
