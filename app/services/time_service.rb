module TimeService
  def self.seconds_to_hm(sec)
    [sec / 3600, sec / 60 % 60].map { |t| t.to_s.rjust(2, '0') }
                               .join(':')
  end

  def self.hm_to_second(hour_minute)
    hour_minute.to_time.seconds_since_midnight
  end

  def self.hms_to_second(hour_minute_second)
    Time.strptime(hour_minute_second, '%H:%M:%S').seconds_since_midnight
  end
end
