class ChangeCountryNameToCountryOnAirports < ActiveRecord::Migration[7.0]
  def change
    rename_column :airports, :country_name, :country
  end
end
