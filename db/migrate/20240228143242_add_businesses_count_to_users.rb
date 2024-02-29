class AddBusinessesCountToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :businesses_count, :integer, null: false, default: 0

    User.find_each do |user|
      user.update! businesses_count: user.businesses.size
    end
  end

  def down
    remove_column :users, :businesses_count
  end
end
