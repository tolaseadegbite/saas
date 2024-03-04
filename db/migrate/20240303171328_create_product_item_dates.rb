class CreateProductItemDates < ActiveRecord::Migration[7.0]
  def change
    create_table :product_item_dates do |t|
      t.date :date
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # Add uniqueness constraints for double dates and customer id
    add_index :product_item_dates, [:date, :customer_id], unique: true

    # Add index to date field for performance issues
    add_index :product_item_dates, :date
  end
end
