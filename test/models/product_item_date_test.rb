# == Schema Information
#
# Table name: product_item_dates
#
#  id          :bigint           not null, primary key
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_product_item_dates_on_customer_id           (customer_id)
#  index_product_item_dates_on_date                  (date)
#  index_product_item_dates_on_date_and_customer_id  (date,customer_id) UNIQUE
#  index_product_item_dates_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProductItemDateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
