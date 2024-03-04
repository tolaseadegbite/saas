# == Schema Information
#
# Table name: customers
#
#  id                       :bigint           not null, primary key
#  email                    :string
#  name                     :string           not null
#  phone_number             :string
#  product_item_dates_count :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  business_id              :bigint           not null
#  user_id                  :bigint           not null
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
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = @business.customers.build(name: 'Tolase kelvin', email: 'tolase@example.com', phone_number: '09100000011', user: @user)
  end

  test 'customer must be valid' do
    assert @customer.valid?
  end

  test 'name must be present' do
    @customer.name = ''
    assert_not @customer.valid?
  end

  test 'name must be less than 50' do
    @customer.name = 'a' * 50 + 'a'
    assert_not @customer.valid?
  end

  test 'name must not be less than 3' do
    @customer.name = 'a' * 2
    assert_not @customer.valid?
  end

  test 'name must be unique' do
    @customer.dup.name = @customer.name
    @customer.dup.save
    assert_not @customer.valid?
  end
end
