# == Schema Information
#
# Table name: store_products
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  store_id   :bigint           not null
#
# Indexes
#
#  index_store_products_on_product_id               (product_id)
#  index_store_products_on_product_id_and_store_id  (product_id,store_id) UNIQUE
#  index_store_products_on_store_id                 (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (store_id => stores.id)
#
class StoreProduct < ApplicationRecord
  validates :product_id, presence: true, uniqueness: {scope: :store_id, message: "Product must be unique"}
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  belongs_to :product
  belongs_to :store, counter_cache: :store_products_count
end
