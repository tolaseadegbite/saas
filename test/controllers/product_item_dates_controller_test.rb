require "test_helper"

class ProductItemDatesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    @product_item_date = product_item_dates(:date_1)
    @user = users(:tolase)
    @other_user = users(:john)
  end

  test "redirect new when not logged in" do
    get new_business_customer_product_item_date_path(@business, @customer)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect create when not logged in" do
    post business_customer_product_item_dates_path(@business, @customer), params: { product: { date: '' } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect edit when not logged in" do
    get edit_business_customer_product_item_date_path(@business, @customer, @product_item_date)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect update when not logged in" do
    patch business_customer_product_item_date_path(@business, @customer, @product_item_date), params: { product_item_date: { date: '' } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect destroy when not logged in" do
    delete business_customer_product_item_date_path(@business, @customer, @product_item_date)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect edit when logged in as wrong user" do
    sign_in @other_user
    get edit_business_customer_product_item_date_path(@business, @customer, @product_item_date)
    assert_redirected_to business_customers_url(@business)
    assert_not flash.empty?
  end

  test "redirect update when logged in as wrong user" do
    sign_in @other_user
    date = 2024-03-04
    patch business_customer_product_item_date_path(@business, @customer, @product_item_date), params: { business: { name: name } }
    assert_redirected_to business_customers_url(@business)
    assert_not flash.empty?
  end

  test "redirect destroy when logged in as wrong user" do
    sign_in @other_user
    delete business_customer_product_item_date_path(@business, @customer, @product_item_date)
    assert_redirected_to business_customers_url(@business)
    assert_not flash.empty?
  end
end
