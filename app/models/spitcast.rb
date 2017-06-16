# frozen_string_literal: true
class Spitcast < Forecast
  class << self
    def site_url
      'http://www.spitcast.com/'
    end

    def api_url(spot)
      "http://api.spitcast.com/api/spot/forecast/#{spot.spitcast_id}/?dcat=week"
    end

    def for_chart
      pluck('round(height, 1)')
    end

    def parse_response(spot, request, responses)
      responses.each do |response|
        next unless response.gmt
        record = unscoped.where(spot: spot, timestamp: Time.zone.parse("#{response.gmt.split[0]} #{response.hour}")).first_or_initialize
        record.api_request = request
        record.height = response.size_ft
        record.rating = case response.shape_full
                        when 'Poor' then 1
                        when 'Poor-Fair' then 2
                        when 'Fair' then 3
                        when 'Fair-Good' then 4
                        when 'Good' then 5
                        else 0
                        end
        record.save
      end
    end
  end
end
