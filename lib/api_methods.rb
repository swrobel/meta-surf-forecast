# frozen_string_literal: true

require 'open-uri'

module ApiMethods
  def api_get(url)
    uri = URI.parse(url)
    open_uri_args = {
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/604.4.7 (KHTML, like Gecko) Version/11.0.2 Safari/604.4.7',
      'Cookie' => "MSW_session=#{ENV['MSW_SESSION_ID']}"
    }
    response = JSON.parse(uri.open(open_uri_args).read, object_class: OpenStruct)
    request = ApiRequest.create(request: url, response: response, success: true, batch_id: UpdateBatch.id)
    OpenStruct.new(request: request, response: response)
  rescue OpenURI::HTTPError => e
    ApiRequest.create(request: url, response: { message: e.message, meta: e.io.meta, status: e.io.status }, success: false, batch_id: UpdateBatch.id)
    false
  end
end
