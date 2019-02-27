# frozen_string_literal: true

require 'open-uri'

module ApiMethods
  def api_get(url, hydra: nil, options: {})
    request = Typhoeus::Request.new(url, options.merge(followlocation: true))
    result = nil

    request.on_complete do |response|
      if response.success?
        data = JSON.parse(response.body, object_class: OpenStruct)
        request = ApiRequest.create(request: url, response: response.body, success: true, batch_id: UpdateBatch.id)
        result = OpenStruct.new(request: request, data: data)
      else
        ApiRequest.create(request: url, response: { message: response.return_message, headers: response.headers, status: response.code }, success: false, batch_id: UpdateBatch.id)
        result = false
      end
    end

    if hydra.present?
      hydra.queue(request)
    else
      request.run
    end

    result
  end
end
