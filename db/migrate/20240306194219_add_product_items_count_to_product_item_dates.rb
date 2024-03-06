class AddProductItemsCountToProductItemDates < ActiveRecord::Migration[7.0]
  def change
    def up
      add_column :product_item_dates, :product_items_count, :integer, null: false, default: 0
  
      ProductItemDate.find_each do |product_item_date|
        product_item_date.update! product_items_count: product_item_date.product_items.size
      end
    end
  
    def down
      remove_column :product_item_dates, :product_items_count
    end
  end
end
