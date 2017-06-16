# frozen_string_literal: true
class SpotsController < ApplicationController
  before_action :set_spot, only: [:edit, :update, :destroy]

  # GET /spots
  # GET /spots.json
  def index
    @forecasts = Spot.connection.select_all <<-SQL
      SELECT id
            ,name
            ,lat
            ,lon
            ,timestamp
            ,round(min(min_height), 1) AS min
            ,round(avg(avg_height) - min(min_height), 1) AS avg_delta
            ,round(max(max_height) - avg(avg_height), 1) AS max_delta
            ,max(max_height) AS max
        FROM
        ( SELECT 'msw',
                 spot_id,
                 timestamp,
                 min_height,
                 max_height,
                 (min_height + max_height) / 2 AS avg_height
         FROM msws
         UNION SELECT 'spitcast',
                      spot_id,
                      timestamp,
                      height AS min_height,
                      height AS max_height,
                      height AS avg_height
         FROM spitcasts
         UNION SELECT 'lola',
                      spot_id,
                      timestamp,
                      min_height,
                      max_height,
                      (min_height + max_height) / 2 AS avg_height
         FROM surfline_lolas
         UNION SELECT 'nearshore',
                      spot_id,
                      timestamp,
                      min_height,
                      max_height,
                      (min_height + max_height) / 2 AS avg_height
         FROM surfline_nearshores) sub
        JOIN spots s ON sub.spot_id = s.id
        WHERE timestamp > now() at time zone 'utc'
        GROUP BY id,
               name,
               lat,
               lon,
               timestamp,
               surfline_id,
               msw_id,
               spitcast_id
        HAVING count(*) = CASE
                            WHEN s.surfline_id IS NULL THEN 0
                            ELSE 2
                        END
                        + CASE
                          WHEN s.msw_id IS NULL THEN 0
                          ELSE 1
                        END
                        + CASE
                            WHEN s.spitcast_id IS NULL THEN 0
                            ELSE 1
                        END
        ORDER BY id,
                 timestamp
    SQL
    @forecasts.map(&:symbolize_keys!)
    @forecasts.map! do |forecast|
      forecast[:time] = helpers.format_timestamp(Time.zone.parse("#{forecast[:timestamp]} UTC"))
    end
    @max = @forecasts.collect { |s| s[:max].to_d }.max
    @forecasts = @forecasts.group_by { |s| { id: s[:id], name: s[:name], lat: s[:lat], lon: s[:lon] } }
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
