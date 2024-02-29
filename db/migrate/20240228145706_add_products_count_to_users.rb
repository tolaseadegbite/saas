class AddProductsCountToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :products_count, :integer, null: false, default: 0

    User.find_each do |user|
      user.update! products_count: user.businesses.size
    end
  end

  def down
    remove_column :users, :products_count
  end
end
