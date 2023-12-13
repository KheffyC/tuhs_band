require "test_helper"

class DonationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get donations_index_url
    assert_response :success
  end

  test "should get payment_confirmation" do
    get donations_payment_confirmation_url
    assert_response :success
  end
end
