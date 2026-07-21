require "test_helper"

class DonationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    School.create!(name: "Test High School")
  end

  test "redirects index when stripe is not configured" do
    with_stripe_config(publishable_key: nil, pricing_table_id: nil, buy_button_id: nil) do
      get donations_url

      assert_redirected_to root_path
    end
  end

  test "renders index when stripe donations are configured" do
    with_stripe_config(publishable_key: "pk_test_123", pricing_table_id: "prctbl_123", buy_button_id: nil) do
      get donations_url

      assert_response :success
      assert_match "Sponsor Our Band", response.body
      assert_match "stripe-pricing-table", response.body
    end
  end
end
