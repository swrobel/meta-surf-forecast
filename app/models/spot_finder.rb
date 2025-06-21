# frozen_string_literal: true

class SpotFinder
  attr_accessor :north, :east, :south, :west

  def initialize(data)
    coords = data.split(',')
    @north = coords.fourth
    @east = coords.third
    @south = coords.second
    @west = coords.first
  end

  def all_spots
    return @all_spots if @all_spots.present?

    @all_spots = []

    surfline_v2_spots.each do |surfline|
      spot = nil
      max_distance = 99_999

      if spot
        spot[:name] = surfline['name']
        unless spot[:match_type]
          spot[:match_type] = :distance
          spot[:distance] = max_distance
        end
      else
        spot = {
          name: surfline['name'],
          lat: surfline['lat'],
          lon: surfline['lon'],
        }
        @all_spots << spot
      end

      spot[:surfline_v2_id] = surfline['_id']
    end

    @all_spots
  end

  def formatted_spots
    out = all_spots.sort_by { |s| s[:lat] }.reverse.pretty_inspect
    out.gsub!(/(:(\w+)\s?=>\s?)/, '\\2: ') # Convert to new hash syntax
    puts out # rubocop:disable Rails/Output
  end

  def surfline_v2_spots
    url = "#{SurflineV2.base_api_url}/kbyg/mapview?north=#{north}&east=#{east}&south=#{south}&west=#{west}"
    @surfline_v2_spots ||= get_data(url).dig('data', 'spots')
  end

private

  def get_data(url)
    response = Typhoeus.get(url)
    JSON.parse(response.body)
  end
end
