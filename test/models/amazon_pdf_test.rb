# == Schema Information
#
# Table name: amazon_pdfs
#
#  id                  :bigint           not null, primary key
#  event_date          :date
#  linked_document_url :string
#  name                :string
#  type_of_pdf_group   :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  director_id         :bigint
#  program_id          :bigint
#
# Indexes
#
#  index_amazon_pdfs_on_director_id  (director_id)
#  index_amazon_pdfs_on_program_id   (program_id)
#
# Foreign Keys
#
#  fk_rails_...  (director_id => directors.id)
#  fk_rails_...  (program_id => programs.id)
#
require "test_helper"

class AmazonPdfTest < ActiveSupport::TestCase
  test "requires either an uploaded pdf or a linked document url" do
    amazon_pdf = AmazonPdf.new(name: "Missing Source", type_of_pdf_group: "Other")

    assert_not amazon_pdf.valid?
    assert_includes amazon_pdf.errors.full_messages, "Please attach a PDF or add a Google Docs/Drive link"
  end

  test "accepts an uploaded pdf as the source" do
    amazon_pdf = AmazonPdf.new(
      name: "Uploaded Document",
      type_of_pdf_group: "Other"
    )
    amazon_pdf.pdf.attach(io: file_fixture("test.pdf").open, filename: "test.pdf", content_type: "application/pdf")

    assert amazon_pdf.valid?
    assert amazon_pdf.file_based?
    assert_equal "PDF", amazon_pdf.source_label
    assert_equal "Preview PDF", amazon_pdf.preview_label
  end

  test "accepts a google docs link as the source" do
    amazon_pdf = AmazonPdf.new(
      name: "Linked Document",
      type_of_pdf_group: "Other",
      linked_document_url: "https://docs.google.com/document/d/123/edit"
    )

    assert amazon_pdf.valid?
    assert amazon_pdf.link_based?
    assert_equal "Google Doc", amazon_pdf.source_label
    assert_equal "Open Google Doc", amazon_pdf.preview_label
  end

  test "rejects non google document links" do
    amazon_pdf = AmazonPdf.new(
      name: "External Link",
      type_of_pdf_group: "Other",
      linked_document_url: "https://example.com/file.pdf"
    )

    assert_not amazon_pdf.valid?
    assert_includes amazon_pdf.errors[:linked_document_url], "must be a Google Docs or Google Drive URL"
  end
end
