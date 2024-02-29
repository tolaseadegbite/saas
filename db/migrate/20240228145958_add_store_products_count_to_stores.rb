class AddStoreProductsCountToStores < ActiveRecord::Migration[7.0]
  def up
    add_column :stores, :store_products_count, :integer, null: false, default: 0

    Store.find_each do |store|
      store.update! store_products_count: store.store_products.size
    end
  end

  def down
    remove_column :stores, :store_products_count
  end
end
