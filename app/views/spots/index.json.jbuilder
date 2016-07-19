# frozen_string_literal: true
json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :lat, :lon, :surfline_id, :msw_id, :spitcast_id, :wunder_id
  json.url spot_url(spot, format: :json)
end
