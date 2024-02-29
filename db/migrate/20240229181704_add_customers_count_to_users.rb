class AddCustomersCountToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :customers_count, :integer, null: false, default: 0

    User.find_each do |user|
      user.update! customers_count: user.customers.size
    end
  end

  def down
    remove_column :users, :customers_count
  end
end
