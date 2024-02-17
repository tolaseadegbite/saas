require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get pricing" do
    get pricing_path
    assert_response :success
  end

  test "should get dashboard" do
    get dashboard_path
    assert_response :success
  end
end
