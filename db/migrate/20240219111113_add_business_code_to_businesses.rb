class AddBusinessCodeToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :business_code, :string, null: false
  end
end
