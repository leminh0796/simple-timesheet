class AmountService
  def initialize(timesheet)
    @timesheet = timesheet
  end

  def calculate_amount
    weekday_rates = WeekdayRate.where(day_of_week: @timesheet.date.wday)
    return 0 unless weekday_rates.present?

    result = 0
    weekday_rates.each do |rate|
      working_hours = intersection([@timesheet.start_time, @timesheet.finish_time], [rate.start_time, rate.end_time]) / 3600.0
      result += rate.rate * working_hours.round(2)
    end
    result
  end

  def intersection(timesheet1, timesheet2)
    return 0 if timesheet1.last < timesheet2.first || timesheet2.last < timesheet1.first

    [timesheet1.last, timesheet2.last].min - [timesheet1.first, timesheet2.first].max
  end
end
