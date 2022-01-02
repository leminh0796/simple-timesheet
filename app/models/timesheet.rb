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
class Timesheet < ApplicationRecord
  validates :date, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :finish_time, numericality: { greater_than_or_equal_to: :start_time, message: ' can\'t before start time.' }, unless: -> { start_time.nil? }

  validate :date_cannot_be_in_the_future, :entry_cannot_overlap

  before_save :calculate_amount

  def show_data(with_money: true)
    "#{date.strftime('%d/%m/%Y')}: #{start_time_string} - #{finish_time_string}" + (with_money ? " $#{amount}" : '')
  end

  def start_time_string
    TimeService.seconds_to_hm(start_time)
  end

  def finish_time_string
    TimeService.seconds_to_hm(finish_time)
  end

  def calculate_amount
    assign_attributes amount: AmountService.new(self).calculate_amount
  end

  private

  def date_cannot_be_in_the_future
    errors.add(:date, 'can\'t be in the future') if date.present? && date > Date.today
  end

  def entry_cannot_overlap
    others = Timesheet.where(date: date)
    others.each do |other|
      if start_time <= other.finish_time && other.start_time <= finish_time
        errors.add(:base, "Current entry is overlapping with #{other.show_data(with_money: false)}.")
        break
      end
    end
  end
end
