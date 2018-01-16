class CreateEventMonths < ActiveRecord::Migration
  def change
    create_table :event_months do |t|
      t.string :month
      t.string :status
      t.string :checksum

      t.timestamps null: false
    end
  end
end
