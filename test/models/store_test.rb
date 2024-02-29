# == Schema Information
#
# Table name: stores
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  store_products_count :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  business_id          :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_stores_on_business_id  (business_id)
#  index_stores_on_name         (name) UNIQUE
#  index_stores_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class StoreTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @store = @business.stores.build(name: 'Lekker store', user: @user)
  end

  test 'store must be valid' do
    assert @store.valid?
  end

  test 'name must be present' do
    @store.name = ''
    assert_not @store.valid?
  end

  test 'name must be less than 255' do
    @store.name = 'a' * 255 + 'a'
    assert_not @store.valid?
  end

  test 'name must not be less than 3' do
    @store.name = 'a' * 2
    assert_not @store.valid?
  end

  test 'name must be unique' do
    @store.dup.name = @store.name
    @store.dup.save
    assert_not @store.valid?
  end
end
