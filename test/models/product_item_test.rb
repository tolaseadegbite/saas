# == Schema Information
#
# Table name: product_items
#
#  id                   :bigint           not null, primary key
#  description          :text
#  quantity             :integer          not null
#  unit_price           :decimal(10, 2)   not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :bigint           not null
#  product_item_date_id :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_product_items_on_product_id            (product_id)
#  index_product_items_on_product_item_date_id  (product_item_date_id)
#  index_product_items_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_item_date_id => product_item_dates.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProductItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
