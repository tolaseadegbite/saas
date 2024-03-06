require "test_helper"

class ProductItemDateDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @customer = customers(:customer_1)
    @product_item_date = product_item_dates(:date_1)
    sign_in @user
  end
  test "destroy product item date" do
    delete business_customer_product_item_date_path(@business, @customer, @product_item_date)
    follow_redirect!
    assert_template 'customers/show'
    assert_not flash.empty?
  end
end
