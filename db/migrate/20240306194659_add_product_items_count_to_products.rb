class AddProductItemsCountToProducts < ActiveRecord::Migration[7.0]
  def change
    def up
      add_column :products, :product_items_count, :integer, null: false, default: 0
  
      Product.find_each do |product|
        product.update! product_items_count: product.product_items.size
      end
    end
  
    def down
      remove_column :products, :product_items_count
    end
  end
end
