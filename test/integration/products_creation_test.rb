require "test_helper"

class ProductsCreationTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @product = products(:product_1)
    sign_in @user
  end

  test "should redirect create with invalid information" do
    get business_products_path(@business)
    assert_template 'products/index'
    get new_business_product_path(@business)
    assert_template 'products/new'
    assert_no_difference 'Product.count' do
      post business_products_path(@business), params: { product: { name: '' } }
    end
    assert_response :unprocessable_entity
    assert_template 'products/new'
    assert_select 'div.text-danger'
  end

  test "should create product with valid information" do
    assert_difference 'Product.count', 1 do
      post business_products_path(@business), params: { product: {  name: 'A Test Product',
                                                  description: 'A cool product item',
                                                  product_code: 'cd1ixb',
                                                  quantity: 10,
                                                  unit_price: 3000 } }
    end
  end
end
