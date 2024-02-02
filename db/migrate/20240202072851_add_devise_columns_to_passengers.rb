class AddDeviseColumnsToPassengers < ActiveRecord::Migration[7.0]
  def change
    add_column :passengers, :encrypted_password, :string, null: false, default: ""
    add_column :passengers, :reset_password_token, :string
    add_column :passengers, :reset_password_sent_at, :datetime
    add_column :passengers, :remember_created_at, :datetime
    
    add_index :passengers, :email, unique: true
    add_index :passengers, :reset_password_token, unique: true
  end
end
