require "test_helper"

class MobilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mobile = mobiles(:one)
  end

  test "should get index" do
    get mobiles_url
    assert_response :success
  end

  test "should get new" do
    get new_mobile_url
    assert_response :success
  end

  test "should create mobile" do
    assert_difference("Mobile.count") do
      post mobiles_url, params: { mobile: {  } }
    end

    assert_redirected_to mobile_url(Mobile.last)
  end

  test "should show mobile" do
    get mobile_url(@mobile)
    assert_response :success
  end

  test "should get edit" do
    get edit_mobile_url(@mobile)
    assert_response :success
  end

  test "should update mobile" do
    patch mobile_url(@mobile), params: { mobile: {  } }
    assert_redirected_to mobile_url(@mobile)
  end

  test "should destroy mobile" do
    assert_difference("Mobile.count", -1) do
      delete mobile_url(@mobile)
    end

    assert_redirected_to mobiles_url
  end
end
