class RemoveBookingIdFromPassengers < ActiveRecord::Migration[7.0]
  def change
    remove_column :passengers, :booking_id, :integer
  end
end
