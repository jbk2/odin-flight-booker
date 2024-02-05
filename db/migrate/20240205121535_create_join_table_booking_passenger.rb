class CreateJoinTableBookingPassenger < ActiveRecord::Migration[7.0]
  def change
    create_join_table :bookings, :passengers do |t|
      t.index [:booking_id, :passenger_id], unique: true
      t.index [:passenger_id, :booking_id]
    end
  end
end
