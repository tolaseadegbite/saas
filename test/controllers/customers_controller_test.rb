require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    @user = users(:tolase)
    @other_user = users(:john)
  end

  test "redirect index when not logged in" do
    get business_customers_path(@business)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect new when not logged in" do
    get new_business_customer_path(@business)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect create when not logged in" do
    post business_customers_path(@business), params: { customer: { name: '' } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect edit when not logged in" do
    get edit_business_customer_path(@business, @customer)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect update when not logged in" do
    patch business_customer_path(@business, @customer), params: { business: { name: '' } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect destroy when not logged in" do
    delete business_customer_path(@business, @customer)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect edit when logged in as wrong user" do
    sign_in @other_user
    get edit_business_customer_path(@business, @customer)
    assert_redirected_to businesses_url
    assert_not flash.empty?
  end

  test "redirect update when logged in as wrong user" do
    sign_in @other_user
    name = 'new name'
    patch business_customer_path(@business, @customer), params: { business: { name: name } }
    assert_redirected_to businesses_url
    assert_not flash.empty?
  end

  test "redirect destroy when logged in as wrong user" do
    sign_in @other_user
    delete business_customer_path(@business, @customer)
    assert_redirected_to businesses_url
    assert_not flash.empty?
  end
end
