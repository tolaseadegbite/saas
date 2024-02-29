class AddProductsCountToBusinesses < ActiveRecord::Migration[7.0]
  def up
    add_column :businesses, :products_count, :integer, null: false, default: 0

    Business.find_each do |business|
      business.update! products_count: business.products.size
    end
  end

  def down
    remove_column :businesses, :products_count
  end
end
