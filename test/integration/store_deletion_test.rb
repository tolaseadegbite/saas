require "test_helper"

class StoreDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @business = businesses(:business_1)
    @store = stores(:store_1)
    sign_in @user
  end
  test "destroy store" do
    delete business_store_path(@business, @store)
    follow_redirect!
    assert_template 'stores/index'
    assert_not flash.empty?
  end
end
