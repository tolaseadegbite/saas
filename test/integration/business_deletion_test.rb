require "test_helper"

class BusinessDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SAAS'
    @user = users(:tolase)
    @business = businesses(:business_1)
    @category = categories(:cat_2)
    sign_in @user
  end

  test "destroy business" do
    delete business_path(@business)
    follow_redirect!
    assert_template 'businesses/index'
    assert_not flash.empty?
  end
end
