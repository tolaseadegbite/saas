class CreateStoreProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :store_products do |t|
      t.integer    :quantity, null: false
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :store_products, [:product_id, :store_id], unique: true
  end
end
