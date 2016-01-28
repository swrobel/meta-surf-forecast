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
      response = JSON.parse(Net::HTTP.get(URI(api_url(spot))), object_class: OpenStruct)
    end

    def api_pull(spot)
      parse_response(spot, api_get(spot))
    end
  end
end
