require "test_helper"

class OauthControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get oauth_new_url
    assert_response :success
  end

  test "should get callback" do
    get oauth_callback_url
    assert_response :success
  end
end
