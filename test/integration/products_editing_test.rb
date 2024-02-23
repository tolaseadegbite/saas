require "test_helper"

class ProductsEditingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @product = products(:product_1)
    sign_in @user
  end

  test "redirect edit with invalid information" do
    get business_products_path(@business)
    assert_template 'products/index'
    get edit_business_product_path(@business, @product)
    assert_template 'products/edit'
    name = ''
    patch business_product_path(@business, @product), params: { product: { name: name } }
    assert_response :unprocessable_entity
    assert_template 'products/edit'
    assert_select 'div.text-danger'
  end

  test "successful update with valid information" do
    name = 'A new product name'
    description = 'Another product description'
    patch business_product_path(@business, @product), params: { product: { name: name, description: description } }
    follow_redirect!
    assert_template 'products/show'
    assert_not flash.empty?
    assert_equal name, @product.reload.name
    assert_equal description, @product.reload.description
  end
end
