require "test_helper"

class ProductItemDateCreationTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    @product_item_date = product_item_dates(:date_1)
    sign_in @user
  end

  test "should redirect create with invalid information" do
    get business_customer_path(@business, @customer)
    assert_template 'customers/show'
    get new_business_customer_product_item_date_path(@business, @customer)
    assert_template 'product_item_dates/new'
    assert_no_difference 'ProductItemDate.count' do
      post business_customer_product_item_dates_path(@business, @customer), params: { product_item_date: { date: '' } }
    end
    assert_response :unprocessable_entity
    assert_template 'product_item_dates/new'
    assert_select 'div.text-danger'
  end

  test "should create product item date with valid information" do
    assert_difference 'ProductItemDate.count', 1 do
      post business_customer_product_item_dates_path(@business, @customer), params: { product_item_date: {  date: 7.days.ago } }
    end
  end
end
