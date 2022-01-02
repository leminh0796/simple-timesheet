# == Schema Information
#
# Table name: timesheets
#
#  id          :bigint           not null, primary key
#  amount      :float            default(0.0)
#  date        :date             not null
#  finish_time :integer          default(0), not null
#  start_time  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :timesheet do
    date { Faker::Date.between(from: 1.month.ago, to: Date.today) }
    start_time { rand(0..43_219) }
    finish_time { rand(0..86_439) }
  end
end
