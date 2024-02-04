class ChangeBookingOwnerIdOnBookingToBeNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bookings, :booking_owner_id, true
  end
end
