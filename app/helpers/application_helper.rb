# frozen_string_literal: true

module ApplicationHelper
  def height_range(min, max)
    return unless min && max
    "#{display_number(min)} - #{display_number(max)} ft"
  end

  def display_number(value)
    number_with_precision(value, precision: 1, strip_insignificant_zeros: true)
  end

  def map_link(target)
    link_to image_tag('map.svg', alt: 'Map Icon'), target, target: 'gmap', title: 'Google Map'
  end

  def forecast_link(image_file, service, target, icon_label = nil)
    link_to target, target: service, title: "#{service} Forecast Page" do
      span_tag = tag.span(icon_label, class: 'forecast-icon-label') if icon_label
      image_tag(image_file, alt: "#{service} Logo") + span_tag
    end
  end

  def msw_link(target)
    forecast_link('Msw.svg', 'MagicSeaweed', target)
  end

  def spitcast_link(target)
    forecast_link('Spitcast.png', 'Spitcast', target)
  end

  def surfline_link(target, icon_label = nil)
    forecast_link('Surfline.svg', 'Surfline', target, icon_label)
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
