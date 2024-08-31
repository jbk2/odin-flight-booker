class AddAdminToPassenger < ActiveRecord::Migration[7.0]
  def change
    add_column :passengers, :admin, :boolean, default: false, null: false
  end
end
