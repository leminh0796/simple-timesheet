class CreateWeekdayRates < ActiveRecord::Migration[6.1]
  def change
    create_table :weekday_rates do |t|
      t.integer :day_of_week, null: false
      t.integer :start_time, null: false, default: 0
      t.integer :end_time, null: false, default: 0
      t.float :rate, null: false, default: 0.0
      t.timestamps
    end
  end
end
