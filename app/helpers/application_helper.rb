# frozen_string_literal: true

module ApplicationHelper
  def height_range(min, max)
    return unless min && max

    "#{display_number(min)} - #{display_number(max)} ft"
  end

  def display_number(value)
    number_with_precision(value, precision: 1, strip_insignificant_zeros: true)
  end

  def icon_link(icon:, name:, url:)
    link_to image_tag("//cdn.jsdelivr.net/npm/@mdi/svg@5.8.55/svg/#{icon}.svg", alt: "#{name} Icon"), url, target: name.parameterize, title: name, class: 'icon'
  end

  def map_link(lat, lon)
    icon_link(icon: 'map-marker-radius', name: 'Google Map', url: "https://www.google.com/maps/?q=#{lat},#{lon}&ll=#{lat},#{lon}&z=10")
  end

  def service_icon(image_file, service, icon_label = nil)
    span_tag = tag.span(icon_label, class: 'forecast-icon-label') if icon_label
    image_pack_tag("static/images/#{image_file}", alt: "#{service} Logo") + span_tag
  end

  def service_link(image_file, service, target, icon_label = nil)
    link_to target, target: service, title: "#{service} Forecast Page", class: 'icon logo' do
      service_icon(image_file, service, icon_label)
    end
  end

  def msw_link(target)
    service_link('Msw.svg', 'MagicSeaweed', target)
  end

  def spitcast_link(target)
    service_link('Spitcast.png', 'Spitcast', target)
  end

  def surfline_link(target, icon_label = nil)
    service_link('Surfline.svg', 'Surfline', target, icon_label)
  end

  def format_timestamps(timestamps)
    timestamps.map do |stamp|
      format_timestamp(stamp)
    end
  end

  def format_timestamp(stamp)
    formatted = stamp.strftime('%a')[0..-2] # 2 character day
    formatted += ' '
    formatted += if stamp.hour.zero? && stamp.min.zero?
                   stamp.strftime('%-m/%-d') # Midnight
                 else
                   stamp.strftime('%-I%P')[0..-2] # a/p rather than am/pm
                 end
    formatted
  end
end
