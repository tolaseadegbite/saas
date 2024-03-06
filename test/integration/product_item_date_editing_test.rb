require "test_helper"

class ProductItemDateEditingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    @product_item_date = product_item_dates(:date_1)
    sign_in @user
  end

  test "redirect edit with invalid information" do
    get business_customer_path(@business, @customer)
    assert_template 'customers/show'
    get edit_business_customer_product_item_date_path(@business, @customer, @product_item_date)
    assert_template 'product_item_dates/edit'
    date = ''
    patch business_customer_product_item_date_path(@business, @customer, @product_item_date), params: { product_item_date: { date: date } }
    assert_response :unprocessable_entity
    assert_template 'product_item_dates/edit'
    assert_select 'div.text-danger'
  end

  test "successful update with valid information" do
    date = 5.day.ago.to_date
    patch business_customer_product_item_date_path(@business, @customer, @product_item_date), params: { product_item_date: { date: date } }
    follow_redirect!
    assert_template 'customers/show'
    assert_not flash.empty?
    assert_equal date, @product_item_date.reload.date
  end
end
