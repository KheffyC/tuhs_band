require "test_helper"

class AmazonPdfsControllerTest < ActionDispatch::IntegrationTest
  setup do
    ActiveStorage::Current.url_options = { host: "www.example.com", protocol: "http" }

    @school = School.create!(name: "Test High School")
    @program_one = @school.programs.create!(name: "Symphonic Band", short_name: "Band")
    @program_two = @school.programs.create!(name: "Jazz Band", short_name: "Jazz")

    @general_pdf = create_pdf!(
      name: "General Itinerary",
      type_of_pdf_group: "Itinerary"
    )
    @band_pdf = create_pdf!(
      name: "Band Itinerary",
      type_of_pdf_group: "Itinerary",
      program: @program_one
    )
    @jazz_schedule = create_pdf!(
      name: "Jazz Schedule",
      type_of_pdf_group: "Schedules",
      program: @program_two
    )
    create_pdf!(
      name: "Private Band Contract",
      type_of_pdf_group: "Student Forms",
      program: @program_one
    )
  end

  test "index includes program specific documents by default" do
    get amazon_pdfs_path

    assert_response :success
    assert_match "General Itinerary", response.body
    assert_match "Band Itinerary", response.body
    assert_match "Jazz Schedule", response.body
    assert_no_match "Private Band Contract", response.body
  end

  test "index filters documents by program" do
    get amazon_pdfs_path, params: { program_id: @program_one.id }

    assert_response :success
    assert_match "Band Itinerary", response.body
    assert_no_match "General Itinerary", response.body
    assert_no_match "Jazz Schedule", response.body
  end

  test "index combines group and program filters" do
    get amazon_pdfs_path, params: { group: "Schedules", program_id: @program_two.id }

    assert_response :success
    assert_match "Jazz Schedule", response.body
    assert_no_match "Band Itinerary", response.body
    assert_no_match "General Itinerary", response.body
  end

  private

  def create_pdf!(name:, type_of_pdf_group:, program: nil)
    AmazonPdf.create!(
      name: name,
      type_of_pdf_group: type_of_pdf_group,
      program: program,
      pdf: fixture_file_upload("test.pdf", "application/pdf")
    )
  end
end
