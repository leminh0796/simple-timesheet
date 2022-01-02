# == Schema Information
#
# Table name: weekday_rates
#
#  id          :bigint           not null, primary key
#  day_of_week :integer          not null
#  end_time    :integer          default(0), not null
#  rate        :float            default(0.0), not null
#  start_time  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class WeekdayRate < ApplicationRecord
  validate :weekrate_cannot_overlap
  enum day_of_week: { sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6 }

  private

  def weekrate_cannot_overlap
    others = WeekdayRate.where(day_of_week: day_of_week)
    others.each do |other|
      if start_time <= other.end_time && other.start_time <= end_time
        errors.add(:base, 'Weekday rate is overlapping.')
        break
      end
    end
  end
end
