# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  description  :text
#  name         :string           not null
#  product_code :string           not null
#  quantity     :integer          not null
#  unit_price   :decimal(10, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  business_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_products_on_business_id  (business_id)
#  index_products_on_name         (name) UNIQUE
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @product = @business.products.build(name: 'Elepaq Generator', description: 'Nothing much', quantity: 1, unit_price: 550000.00, product_code: 'sh98ss', user: @user)
  end

  test 'product must be valid' do
    assert @product.valid?
  end

  test 'name must be present' do
    @product.name = ''
    assert_not @product.valid?
  end

  test 'name must be less than 50' do
    @product.name = 'a' * 50 + 'a'
    assert_not @product.valid?
  end

  test 'name must not be less than 3' do
    @product.name = 'a' * 2
    assert_not @product.valid?
  end

  test 'name must be unique' do
    @product.dup.name = @product.name
    @product.dup.save
    assert_not @business.valid?
  end
end
