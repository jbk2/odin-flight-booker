class ChangeEncryptedPasswordOnPassengerToBeNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :passengers, :encrypted_password, true
  end
end
