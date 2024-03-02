require "test_helper"

class CustomerEditingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    sign_in @user
  end

  test "redirect edit with invalid information" do
    get business_customers_path(@business)
    assert_template 'customers/index'
    get edit_business_customer_path(@business, @customer)
    assert_template 'customers/edit'
    name = ''
    patch business_customer_path(@business, @customer), params: { customer: { name: name } }
    assert_response :unprocessable_entity
    assert_template 'customers/edit'
    assert_select 'div.text-danger'
  end

  test "successful update with valid information" do
    name = 'Customer name'
    email = 'customer_name@example.com'
    patch business_customer_path(@business, @customer), params: { customer: { name: name, email: email } }
    follow_redirect!
    assert_template 'customers/index'
    assert_not flash.empty?
    assert_equal name, @customer.reload.name
    assert_equal email, @customer.reload.email
  end
end
