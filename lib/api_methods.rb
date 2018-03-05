# frozen_string_literal: true

require 'open-uri'

module ApiMethods
  def api_get(url)
    uri = URI.parse(url)
    response = JSON.parse(uri.open('User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/604.4.7 (KHTML, like Gecko) Version/11.0.2 Safari/604.4.7').read, object_class: OpenStruct)
    request = ApiRequest.create(request: url, response: response, success: true)
    OpenStruct.new(request: request, response: response)
  rescue OpenURI::HTTPError => e
    ApiRequest.create(request: url, response: { message: e.message, meta: e.io.meta, status: e.io.status }, success: false)
    false
  end
end
