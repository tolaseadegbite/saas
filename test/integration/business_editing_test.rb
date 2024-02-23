require "test_helper"

class BusinessEditingTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @category = categories(:cat_2)
    sign_in @user
  end

  test "redirect edit with invalid information" do
    get businesses_path
    assert_template 'businesses/index'
    get edit_business_path(@business)
    assert_template 'businesses/edit'
    assert_select 'title', "Edit Business | #{@base_title}"
    name = ''
    patch business_path(@business), params: { business: { name: name } }
    assert_response :unprocessable_entity
    assert_template 'businesses/edit'
    assert_select 'div.text-danger'
  end

  test "successful update with invalid information" do
    name = 'A new business name'
    description = 'Another business description'
    patch business_path(@business), params: { business: { name: name, description: description } }
    follow_redirect!
    assert_template 'businesses/show'
    assert_not flash.empty?
    assert_equal name, @business.reload.name
    assert_equal description, @business.reload.description
  end
end
