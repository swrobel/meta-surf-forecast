module Timezones
  extend ActiveSupport::Concern

  included do
    memoize def timezone_obj
      ActiveSupport::TimeZone.new(timezone)
    end

    def utc_stamp_to_local(stamp)
      Time.zone.at(stamp + timezone_obj.at(stamp).utc_offset)
    end
  end
end
