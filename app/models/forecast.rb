class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :spot

  class << self
    def current
      where("? < timestamp", Time.now)
    end

    def ordered
      order(:spot_id, :timestamp)
    end

    def default_scope
      current.ordered
    end

    def api_get(spot)
      Net::HTTP.get(URI(api_url(spot)))
    end

    def api_pull(spot)
      response = api_get(spot)
      ApiRequest.create(request: api_url(spot), response: response)
      parse_response(spot, JSON.parse(response, object_class: OpenStruct))
    end
  end
end
