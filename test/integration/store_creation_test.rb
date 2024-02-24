require "test_helper"

class StoreCreationTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @store = stores(:store_1)
    sign_in @user
  end

  test "should redirect create with invalid information" do
    get business_stores_path(@business)
    assert_template 'stores/index'
    get new_business_store_path(@business)
    assert_template 'stores/new'
    assert_no_difference 'Store.count' do
      post business_stores_path(@business), params: { store: { name: '' } }
    end
    assert_response :unprocessable_entity
    assert_template 'stores/new'
    assert_select 'div.text-danger'
  end

  test "should create store with valid information" do
    assert_difference 'Store.count', 1 do
      post business_stores_path(@business), params: { store: {  name: 'A Test store' } }
    end
  end
end
