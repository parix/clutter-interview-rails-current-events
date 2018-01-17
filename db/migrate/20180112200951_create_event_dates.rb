class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
			t.integer :event_month_id
      t.date :date

      t.timestamps null: false
    end
    add_index :event_dates, :date
  end
end
