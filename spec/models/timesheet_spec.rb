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
  pending "add some examples to (or delete) #{__FILE__}"
end
