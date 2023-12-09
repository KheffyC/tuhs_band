require "test_helper"

class PracticeHubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get practice_hubs_index_url
    assert_response :success
  end
end
