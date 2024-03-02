require "test_helper"

class CustomerDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    sign_in @user
  end
  test "destroy customer" do
    delete business_customer_path(@business, @customer)
    follow_redirect!
    assert_template 'customers/index'
    assert_not flash.empty?
  end
end
