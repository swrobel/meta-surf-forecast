require 'open-uri'

class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :api_request
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
        request = ApiRequest.create(request: url, response: response, success: true)
        parse_response(spot, request, JSON.parse(response, object_class: OpenStruct))
      rescue OpenURI::HTTPError => e
        ApiRequest.create(request: url, response: e, success: false)
      end
    end
  end
end
