require "test_helper"

class ProductsDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @product = products(:product_1)
    sign_in @user
  end
  test "destroy product" do
    delete business_product_path(@business, @product)
    follow_redirect!
    assert_template 'products/index'
    assert_not flash.empty?
  end
end
