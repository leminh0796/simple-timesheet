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
require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  it 'is invalid without date' do
    entry = build :timesheet, date: nil
    expect(entry).not_to be_valid
  end

  it 'is invalid if date in the future' do
    entry = build :timesheet, date: Date.today + rand(1..100).to_i.days
    expect(entry).not_to be_valid
  end

  it 'is invalid without start time' do
    entry = build :timesheet, start_time: nil
    expect(entry).not_to be_valid
  end

  it 'is invalid without finish time' do
    entry = build :timesheet, finish_time: nil
    expect(entry).not_to be_valid
  end

  it 'is invalid if finish time before start time' do
    entry = build :timesheet, start_time: '09:00'.to_time.seconds_since_midnight, finish_time: '08:30'.to_time.seconds_since_midnight
    expect(entry).not_to be_valid
  end

  it 'cannot have overlapping entries' do
    create :timesheet, date: Date.today, start_time: '09:00'.to_time.seconds_since_midnight, finish_time: '11:30'.to_time.seconds_since_midnight
    entry2 = build :timesheet, date: Date.today, start_time: '11:00'.to_time.seconds_since_midnight, finish_time: '15:00'.to_time.seconds_since_midnight
    expect(entry2).not_to be_valid
  end
end
