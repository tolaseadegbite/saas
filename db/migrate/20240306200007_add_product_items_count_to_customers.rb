class AddProductItemsCountToCustomers < ActiveRecord::Migration[7.0]
  def change
    def up
      add_column :customers, :product_items_count, :integer, null: false, default: 0
  
      Customer.find_each do |customer|
        customer.update! product_items_count: customer.product_items.size
      end
    end
  
    def down
      remove_column :customers, :product_items_count
    end
  end
end
