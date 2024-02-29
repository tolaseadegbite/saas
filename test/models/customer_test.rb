# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  email        :string
#  name         :string           not null
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  business_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_customers_on_business_id   (business_id)
#  index_customers_on_email         (email) UNIQUE
#  index_customers_on_name          (name) UNIQUE
#  index_customers_on_phone_number  (phone_number) UNIQUE
#  index_customers_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
