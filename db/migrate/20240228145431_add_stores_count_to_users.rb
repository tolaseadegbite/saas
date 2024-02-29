class AddStoresCountToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :stores_count, :integer, null: false, default: 0

    User.find_each do |user|
      user.update! stores_count: user.businesses.size
    end
  end

  def down
    remove_column :users, :stores_count
  end
end
