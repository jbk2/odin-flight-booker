class AddBookingOwnerIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :booking_owner, null: false, foreign_key: { to_table: :passengers }
  end
end
