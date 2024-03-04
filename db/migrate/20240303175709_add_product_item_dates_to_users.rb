class AddProductItemDatesToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :product_item_dates_count, :integer, null: false, default: 0

    User.find_each do |user|
      user.update! product_item_dates_count: user.product_item_dates.size
    end
  end

  def down
    remove_column :users, :product_item_dates_count
  end
end
