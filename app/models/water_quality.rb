# frozen_string_literal: true
class WaterQuality < ApplicationRecord
  extend ApiMethods

  belongs_to :dept, class_name: 'WaterQualityDepartment', foreign_key: :dept_id

  class << self
    def la_public_health_pull
      dept = WaterQualityDepartment.find_by_code('LAPH')
      if (result = api_get(dept.url))
        html = Nokogiri::HTML(result.response)
        timestamp = Time.zone.strptime(html.css('blockquote').css('span.contEmphasis').text.squish, '%m/%d/%Y %H:%M %p')
        html.css('table[width="763"]').css('tr').select { |tr| tr['bgcolor'].nil? }.each do |tr|
          tds = tr.css('td')
          site_id = tds[0].text.squish
          name = tds[1].text.squish
          /ll=([\-0-9.]*),([\-0-9.]*)/ =~ tds[1].css('a').first.try(:[], 'href')
          lat = Regexp.last_match(1)
          lon = Regexp.last_match(2)
          ok = tds[2].css('img').first.try(:[], 'src') == 'grncheck.gif'
          comments = tds[3].text.squish
          wq = where(dept_id: dept.id, site_id: site_id, timestamp: timestamp).first_or_initialize
          wq.name = name
          wq.ok = ok
          wq.comments = comments
          wq.timestamp = timestamp
          wq.lat = lat
          wq.lon = lon
          wq.save
        end
      end
    end
  end
end
