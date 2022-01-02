# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initial weekday rates
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
