class AddPhoneNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :bigint
    add_index :users, :phone_number, unique: true
  end
end
