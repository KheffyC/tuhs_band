require "test_helper"

class AmazonPdfsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActiveJob::TestHelper

  setup do
    ActiveStorage::Current.url_options = { host: "www.example.com", protocol: "http" }

    @school = School.create!(name: "Test High School")
    @program_one = @school.programs.create!(name: "Symphonic Band", short_name: "Band")
    @program_two = @school.programs.create!(name: "Jazz Band", short_name: "Jazz")
    @director = Director.create!(email: "director@example.com", password: "password123", password_confirmation: "password123")

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

  test "new loads without requiring amazon_pdf params" do
    sign_in @director

    get new_amazon_pdf_path

    assert_response :success
    assert_match "Upload Document", response.body
  end

  test "creates an uploaded document" do
    sign_in @director

    assert_difference("AmazonPdf.count", 1) do
      post amazon_pdfs_path, params: {
        amazon_pdf: {
          name: "Upload Flow",
          type_of_pdf_group: "Other",
          source_mode: "upload",
          pdf: fixture_file_upload("test.pdf", "application/pdf")
        }
      }
    end

    assert_redirected_to amazon_pdfs_path
    created_pdf = AmazonPdf.order(:created_at).last
    assert created_pdf.file_based?
    assert_not created_pdf.link_based?
    assert_not_nil created_pdf.pdf.blob
  end

  test "creates a linked document" do
    sign_in @director

    assert_difference("AmazonPdf.count", 1) do
      post amazon_pdfs_path, params: {
        amazon_pdf: {
          name: "Link Flow",
          type_of_pdf_group: "Other",
          source_mode: "link",
          linked_document_url: "https://docs.google.com/document/d/123/edit"
        }
      }
    end

    assert_redirected_to amazon_pdfs_path
    created_pdf = AmazonPdf.order(:created_at).last
    assert created_pdf.link_based?
    assert_not created_pdf.pdf.attached?
    assert_equal "https://docs.google.com/document/d/123/edit", created_pdf.linked_document_url
  end

  test "switching an uploaded document to a linked document purges the file" do
    sign_in @director

    uploaded_pdf = create_pdf!(
      name: "Editable Document",
      type_of_pdf_group: "Other"
    )

    perform_enqueued_jobs do
      patch amazon_pdf_path(uploaded_pdf), params: {
        amazon_pdf: {
          name: "Editable Document",
          type_of_pdf_group: "Other",
          source_mode: "link",
          linked_document_url: "https://drive.google.com/file/d/123/view"
        }
      }
    end

    assert_redirected_to amazon_pdf_path(uploaded_pdf)
    uploaded_pdf.reload
    assert uploaded_pdf.link_based?
    assert_not uploaded_pdf.pdf.attached?
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
