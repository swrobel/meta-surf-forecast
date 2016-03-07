require 'open-uri'

class Forecast < ApplicationRecord
  self.abstract_class = true

  belongs_to :api_request
  belongs_to :spot

  class << self
    def current
      where('? < timestamp', Time.now.utc)
    end

    def ordered
      order(:spot_id, :timestamp)
    end

    def default_scope
      current.ordered
    end

    def api_url(spot)
      raise_not_implemented_error
    end

    def parse_response(spot, request, responses)
      raise_not_implemented_error
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

  private

    def raise_not_implemented_error
      raise NotImplementedError, "Subclass should override method '#{caller[0][/`.*'/][1..-2]}'"
    end
  end
end
