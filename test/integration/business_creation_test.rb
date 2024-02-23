require "test_helper"

class BusinessCreationTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @category = categories(:cat_2)
    sign_in @user
  end

  test "should redirect create with invalid information" do
    get businesses_path
    assert_template 'businesses/index'
    assert_select 'title', "My Businesses | #{@base_title}"
    get new_business_path
    assert_template 'businesses/new'
    assert_no_difference 'Business.count' do
      post businesses_path, params: { business: { name: '' } }
    end
    assert_response :unprocessable_entity
    assert_template 'businesses/new'
    assert_select 'div.text-danger'
  end

  test "should create business with valid information" do
    assert_difference 'Business.count', 1 do
      post businesses_path, params: { business: {  name: 'A Test Business',
                                                  description: 'A cool business startup',
                                                  business_code: 'cd1ixb',
                                                  category_id: @category.id } }
    end
  end
end
