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
class AmazonPdf < ApplicationRecord
  GROUP_ORDER = ['Department Handbook', 'Itinerary', 'Schedules', 'Syllabus'].freeze
  SOURCE_MODES = %w[upload link].freeze
  GOOGLE_DOCUMENT_HOSTS = %w[docs.google.com drive.google.com].freeze

  has_one_attached :pdf, dependent: :destroy

  belongs_to :director, optional: true
  belongs_to :program, optional: true
  belongs_to :music_sheet, optional: true

  attr_accessor :source_mode

  validates :name, presence: { message: 'Please enter a name for the PDF' }
  validates :type_of_pdf_group, presence: true
  validate :document_source_present
  validate :linked_document_url_is_valid, if: -> { linked_document_url.present? }
  validate :linked_document_url_is_google_docs_or_drive, if: -> { linked_document_url.present? }

  scope :library_documents, -> { where.not(type_of_pdf_group: 'Student Forms') }
  scope :student_forms, -> { where(type_of_pdf_group: 'Student Forms') }

  def to_s
    name
  end

  def source_mode
    @source_mode.presence || (link_based? ? 'link' : 'upload')
  end

  def link_based?
    linked_document_url.present?
  end

  def file_based?
    !link_based? && pdf.attached?
  end

  def source_label
    return 'Google Doc' if google_docs_url?
    return 'Google Drive' if google_drive_url?
    return 'Linked Document' if link_based?

    'PDF'
  end

  def preview_label
    return 'Open Google Doc' if google_docs_url?
    return 'Open Google Drive File' if google_drive_url?
    return 'Preview Linked Document' if link_based?

    'Preview PDF'
  end

  def source_url
    linked_document_url.presence || pdf_url
  end

  def url
    source_url
  end

  def pdf_url
    Rails.application.routes.url_helpers.rails_blob_url(pdf, only_path: true) if pdf.attached?
  end

  def google_docs_url?
    uri = parsed_linked_document_uri
    uri&.host&.include?('docs.google.com')
  end

  def google_drive_url?
    uri = parsed_linked_document_uri
    uri&.host&.include?('drive.google.com')
  end

  private

  def document_source_present
    return if pdf.attached? || linked_document_url.present?

    errors.add(:base, 'Please attach a PDF or add a Google Docs/Drive link')
  end

  def linked_document_url_is_valid
    parsed_linked_document_uri
  rescue URI::InvalidURIError
    errors.add(:linked_document_url, 'must be a valid URL')
  end

  def linked_document_url_is_google_docs_or_drive
    return unless parsed_linked_document_uri.present?
    return if google_docs_url? || google_drive_url?

    errors.add(:linked_document_url, 'must be a Google Docs or Google Drive URL')
  rescue URI::InvalidURIError
    errors.add(:linked_document_url, 'must be a valid URL')
  end

  def parsed_linked_document_uri
    @parsed_linked_document_uri ||= URI.parse(linked_document_url.to_s)
  end
end
