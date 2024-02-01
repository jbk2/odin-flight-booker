class RemoveNoOfPassengersFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :no_of_passengers, :integer
  end
end
