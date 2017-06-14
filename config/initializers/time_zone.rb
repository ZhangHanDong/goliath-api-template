TIMEZONE = ActiveSupport::TimeZone.new('Beijing')

#set active_record timezone, please Notice the order of the following settings:
ActiveRecord::Base.time_zone_aware_attributes = true
Time.zone = "Beijing"
