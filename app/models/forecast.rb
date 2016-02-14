require 'open-uri'

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

    def api_pull(spot)
      url = api_url(spot)
      begin
        response = open(url).read
        ApiRequest.create(request: url, response: response)
        parse_response(spot, JSON.parse(response, object_class: OpenStruct))
      rescue OpenURI::HTTPError => e
        ApiRequest.create(request: url, response: e)
      end
    end
  end
end
