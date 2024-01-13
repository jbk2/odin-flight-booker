class AddCountryNameToAirports < ActiveRecord::Migration[7.0]
  def change
    add_column :airports, :country_name, :string
  end
end
