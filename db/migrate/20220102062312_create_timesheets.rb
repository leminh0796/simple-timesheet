class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.date :date, null: false
      t.integer :start_time, null: false, default: 0
      t.integer :finish_time, null: false, default: 0
      t.float :amount, default: 0.0

      t.timestamps
    end
  end
end
