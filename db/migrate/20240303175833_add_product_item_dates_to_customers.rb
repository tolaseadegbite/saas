class AddProductItemDatesToCustomers < ActiveRecord::Migration[7.0]
  def up
    add_column :customers, :product_item_dates_count, :integer, null: false, default: 0

    Customer.find_each do |customer|
      customer.update! product_item_dates_count: customer.product_item_dates.size
    end
  end

  def down
    remove_column :customers, :product_item_dates_count
  end
end
