class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.integer :duration
      t.string :venue

      t.timestamps
    end
  end
end
