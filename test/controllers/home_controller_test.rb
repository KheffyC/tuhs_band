require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school = School.create!(name: "Test High School")
  end

  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "about page uses the school about hero image override" do
    @school.update!(about_hero_image: "logo.png")

    get home_about_url

    assert_response :success
    assert_match %r{/assets/logo-[^\"]+\.png}, response.body
  end
end
