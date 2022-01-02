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
require 'rails_helper'

RSpec.describe WeekdayRate, type: :model do
  before :all do
    weekday_rates = [
      {
        day_of_week: 'sunday',
        start_time: 0,
        end_time: TimeService.hms_to_second('23:59:59'),
        rate: 47
      },
      {
        day_of_week: 'saturday',
        start_time: 0,
        end_time: TimeService.hms_to_second('23:59:59'),
        rate: 47
      }
    ]
    %w[monday wednesday friday].each do |weekday|
      weekday_rates.concat [
        {
          day_of_week: weekday,
          start_time: 0,
          end_time: TimeService.hms_to_second('06:59:59'),
          rate: 34
        },
        {
          day_of_week: weekday,
          start_time: TimeService.hms_to_second('07:00:00'),
          end_time: TimeService.hms_to_second('18:59:59'),
          rate: 22
        },
        {
          day_of_week: weekday,
          start_time: TimeService.hms_to_second('19:00:00'),
          end_time: TimeService.hms_to_second('23:59:59'),
          rate: 34
        }
      ]
    end
    %w[tuesday thursday].each do |weekday|
      weekday_rates.concat [
        {
          day_of_week: weekday,
          start_time: 0,
          end_time: TimeService.hms_to_second('04:59:59'),
          rate: 35
        },
        {
          day_of_week: weekday,
          start_time: TimeService.hms_to_second('05:00:00'),
          end_time: TimeService.hms_to_second('16:59:59'),
          rate: 25
        },
        {
          day_of_week: weekday,
          start_time: TimeService.hms_to_second('17:00:00'),
          end_time: TimeService.hms_to_second('23:59:59'),
          rate: 35
        }
      ]
    end
    WeekdayRate.create weekday_rates
  end

  it 'is correct when calculate timesheet amount' do
    monday = create :timesheet, date: '15/04/2019'.to_date, start_time: TimeService.hm_to_second('10:00'), finish_time: TimeService.hm_to_second('17:00')
    expect(monday.amount).to eq(154)

    tuesday = create :timesheet, date: '16/04/2019'.to_date, start_time: TimeService.hm_to_second('12:00'), finish_time: TimeService.hm_to_second('20:15')
    expect(tuesday.amount).to eq(238.75)

    wednesday1 = create :timesheet, date: '17/04/2019'.to_date, start_time: TimeService.hm_to_second('04:00'), finish_time: TimeService.hm_to_second('21:30')
    expect(wednesday1.amount).to eq(451)

    wednesday2 = create :timesheet, date: '24/04/2019'.to_date, start_time: TimeService.hm_to_second('02:00'), finish_time: TimeService.hm_to_second('06:00')
    expect(wednesday2.amount).to eq(136)

    weekend = create :timesheet, date: '20/04/2019'.to_date, start_time: TimeService.hm_to_second('15:30'), finish_time: TimeService.hm_to_second('20:00')
    expect(weekend.amount).to eq(211.5)

    friday = create :timesheet, date: '31/12/2021'.to_date, start_time: TimeService.hm_to_second('10:30'), finish_time: TimeService.hm_to_second('23:00')
    expect(friday.amount).to eq(323)
  end
end
