require 'open-uri'

class Forecast < ApplicationRecord
  extend ApiMethods
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
      if (result = api_get(api_url(spot)))
        parse_response(spot, result.request, JSON.parse(result.response, object_class: OpenStruct))
      end
    end

  private

    def raise_not_implemented_error
      raise NotImplementedError, "Subclass should override method '#{caller[0][/`.*'/][1..-2]}'"
    end
  end
end
