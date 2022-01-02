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
FactoryBot.define do
  factory :weekday_rate do
    
  end
end
