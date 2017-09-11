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
      stamp.strftime('%a %-I%P')[0..-2]
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

  def rating_color(rating, series)
    colors = {
      0 => {
        max: 'D9B0B7',
        avg: 'C3818C',
        min: 'B46270',
      },
      1 => {
        max: 'F49B90',
        avg: 'EE6352',
        min: 'D95A4B',
      },
      2 => {
        max: 'FBD698',
        avg: 'FAC05E',
        min: 'E4AF56',
      },
      3 => {
        max: 'FEF8A1',
        avg: 'FEF56C',
        min: 'E7DF63',
      },
      4 => {
        max: '95DFB8',
        avg: '59CD90',
        min: '51BB83',
      },
      5 => {
        max: '9BFFFF',
        avg: '54EAEA',
        min: '00D3D3',
      }
    }
    "##{colors[rating][series]}"
  end

  def rating_text(rating)
    {
      0 => 'Poor',
      1 => 'Poor - Fair',
      2 => 'Fair',
      3 => 'Fair - Good',
      4 => 'Good',
      5 => 'Very Good',
    }[rating]
  end
end
