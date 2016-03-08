module ApiMethods
  def api_get(url)
    response = open(url).read
    request = ApiRequest.create(request: url, response: response, success: true)
    return OpenStruct.new(request: request, response: response)
  rescue OpenURI::HTTPError => e
    ApiRequest.create(request: url, response: e, success: false)
    return false
  end
end
