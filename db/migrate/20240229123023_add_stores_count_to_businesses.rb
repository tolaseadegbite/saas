class AddStoresCountToBusinesses < ActiveRecord::Migration[7.0]
  def up
    add_column :businesses, :stores_count, :integer, null: false, default: 0

    Business.find_each do |business|
      business.update! stores_count: business.stores.size
    end
  end

  def down
    remove_column :businesses, :stores_count
  end
end
