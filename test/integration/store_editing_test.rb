require "test_helper"

class StoreEditingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @store = stores(:store_1)
    sign_in @user
  end

  test "redirect edit with invalid information" do
    get business_stores_path(@business)
    assert_template 'stores/index'
    get edit_business_store_path(@business, @store)
    assert_template 'stores/edit'
    name = ''
    patch business_store_path(@business, @store), params: { store: { name: name } }
    assert_response :unprocessable_entity
    assert_template 'stores/edit'
    assert_select 'div.text-danger'
  end

  test "successful update with valid information" do
    name = 'A new store name'
    patch business_store_path(@business, @store), params: { store: { name: name } }
    follow_redirect!
    assert_template 'stores/show'
    assert_not flash.empty?
    assert_equal name, @store.reload.name
  end
end
