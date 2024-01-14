class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.references :departure_airport, foreign_key: { to_table: 'airports' }, null: false
      t.references :arrival_airport, foreign_key: { to_table: 'airports' }, null: false
      t.datetime :departure_time
      t.datetime :arrival_time

      t.timestamps
    end
  end
end
