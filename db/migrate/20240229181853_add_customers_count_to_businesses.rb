class AddCustomersCountToBusinesses < ActiveRecord::Migration[7.0]
  def up
    add_column :businesses, :customers_count, :integer, null: false, default: 0

    Business.find_each do |business|
      business.update! customers_count: business.customers.size
    end
  end

  def down
    remove_column :businesses, :customers_count
  end
end
