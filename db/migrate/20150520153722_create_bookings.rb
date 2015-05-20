class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
      t.boolean :attending, default: true
      t.timestamps
    end
  end
end


