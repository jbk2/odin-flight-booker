class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :code
      t.string :country_id

      t.timestamps
    end
  end
end
