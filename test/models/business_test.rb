# == Schema Information
#
# Table name: businesses
#
#  id             :bigint           not null, primary key
#  business_code  :string           not null
#  description    :text
#  name           :string
#  products_count :integer          default(0), not null
#  stores_count   :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_businesses_on_category_id  (category_id)
#  index_businesses_on_name         (name) UNIQUE
#  index_businesses_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @category = categories(:cat_1)
    @business = @user.businesses.build(name: 'Business name', description: 'business description', business_code: 'cde7d7', category: @category)
  end

  test 'business must be valid' do
    assert @user.valid?
  end

  test 'name must be present' do
    @business.name = ''
    assert_not @business.valid?
  end

  test 'name must be less than 255' do
    @business.name = 'a' * 255 + 'a'
    assert_not @business.valid?
  end

  test 'name must not be less than 3' do
    @business.name = 'a' * 2
    assert_not @business.valid?
  end

  test 'name must be unique' do
    @business.dup.name = @business.name
    @business.dup.save
    assert_not @business.valid?
  end
end
