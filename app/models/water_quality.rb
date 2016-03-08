class WaterQuality < ApplicationRecord
  extend ApiMethods

  class << self
    def la_public_health_pull
      if (result = api_get('http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm'))
        html = Nokogiri::HTML(result.response)
        updated_at = Time.zone.strptime(html.css('blockquote').css('span.contEmphasis').text.squish, '%m/%d/%Y %H:%M %p')
        html.css('table[width="763"]').css('tr').select { |tr| tr['bgcolor'].nil? }.each do |tr|
          tds = tr.css('td')
          dept_id = tds[0].text.squish
          name = tds[1].text.squish
          ok = tds[2].css('img').first.try(:[], 'src') == 'grncheck.gif'
          comments = tds[3].text.squish
          wq = where(dept_id: dept_id).first_or_initialize
          wq.name = name
          wq.ok = ok
          wq.comments = comments
          wq.updated_at = updated_at
          wq.save
        end
      end
    end
  end
end
