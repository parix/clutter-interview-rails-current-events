class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_date_id
      t.string :title
      t.string :summary
      t.string :image_url

      t.timestamps null: false
    end
  end
end
