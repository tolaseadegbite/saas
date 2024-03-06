class AddProductItemsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    def up
      add_column :users, :product_items_count, :integer, null: false, default: 0
  
      User.find_each do |user|
        user.update! product_items_count: user.product_items.size
      end
    end
  
    def down
      remove_column :users, :product_items_count
    end
  end
end
