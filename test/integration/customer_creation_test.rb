require "test_helper"

class CustomerCreationTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    sign_in @user
  end

  test "should redirect create with invalid information" do
    get business_customers_path(@business)
    assert_template 'customers/index'
    get new_business_customer_path(@business)
    assert_template 'customers/new'
    assert_no_difference 'Customer.count' do
      post business_customers_path(@business), params: { customer: { name: '' } }
    end
    assert_response :unprocessable_entity
    assert_template 'customers/new'
    assert_select 'div.text-danger'
  end

  test "should create customer with valid information" do
    assert_difference 'Customer.count', 1 do
      post business_customers_path(@business), params: { customer: {  name: 'Customer A',
                                                  email: 'customer@customer.com',
                                                  phone_number: '09000001100' } }
    end
  end
end
