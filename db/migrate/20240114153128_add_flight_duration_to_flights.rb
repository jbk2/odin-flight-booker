class AddFlightDurationToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :flight_duration_secs, :integer
  end
end
