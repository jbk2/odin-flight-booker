class MakeBookingIdNullableInPassengers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :passengers, :booking_id, true
  end
end
