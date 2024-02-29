class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone_number
      t.references :user, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, :name, unique: true
    add_index :customers, :email, unique: true
    add_index :customers, :phone_number, unique: true
  end
end
