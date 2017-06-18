# frozen_string_literal: true

require 'test_helper'

class SpotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spot = spots(:one)
  end

  test 'should get index' do
    get spots_url
    assert_response :success
  end

  test 'should get new' do
    get new_spot_url
    assert_response :success
  end

  test 'should create spot' do
    assert_difference('Spot.count') do
      post spots_url, params: { spot: { lat: @spot.lat, lon: @spot.lon, msw_id: @spot.msw_id, name: @spot.name, spitcast_id: @spot.spitcast_id, surfline_id: @spot.surfline_id, wunder_id: @spot.wunder_id } }
    end

    assert_redirected_to spot_path(Spot.last)
  end

  test 'should show spot' do
    get spot_url(@spot)
    assert_response :success
  end

  test 'should get edit' do
    get edit_spot_url(@spot)
    assert_response :success
  end

  test 'should update spot' do
    patch spot_url(@spot), params: { spot: { lat: @spot.lat, lon: @spot.lon, msw_id: @spot.msw_id, name: @spot.name, spitcast_id: @spot.spitcast_id, surfline_id: @spot.surfline_id, wunder_id: @spot.wunder_id } }
    assert_redirected_to spot_path(@spot)
  end

  test 'should destroy spot' do
    assert_difference('Spot.count', -1) do
      delete spot_url(@spot)
    end

    assert_redirected_to spots_path
  end
end
