# frozen_string_literal: true

module ApplicationHelper
  def height_range(min, max)
    return unless min && max
    "#{display_number(min)} - #{display_number(max)} ft"
  end

  def display_number(value)
    number_with_precision(value, precision: 1, strip_insignificant_zeros: true)
  end

  def map_link(lat, lon)
    link_to image_tag('map.svg', alt: 'Map Icon'), Spot.map_url(lat, lon), target: 'gmap'
  end

  def format_timestamps(timestamps)
    timestamps.map do |stamp|
      format_timestamp(stamp)
    end
  end

  def format_timestamp(stamp)
    if stamp.hour.zero? && stamp.min.zero? # Midnight
      stamp.strftime('%a %b %-d')
    else
      stamp.strftime('%a %-I%P')
    end
  end

  def get_minimums(heights)
    heights.map do |height_group|
      height_group[0]
    end
  end

  def get_maximum_deltas(heights)
    heights.map do |height_group|
      height_group[1] - height_group[0]
    end
  end
end
