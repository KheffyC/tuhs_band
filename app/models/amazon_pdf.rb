# == Schema Information
#
# Table name: amazon_pdfs
#
#  id                :bigint           not null, primary key
#  event_date        :date
#  name              :string
#  type_of_pdf_group :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  director_id       :bigint
#  program_id        :bigint
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
  has_one_attached :pdf, dependent: :destroy

  belongs_to :director, optional: true
  belongs_to :program, optional: true
  belongs_to :music_sheet, optional: true

  validates :name, presence: { message: 'Please enter a name for the PDF' }
  validates :pdf, presence: true
  validates :type_of_pdf_group, presence: true

  scope :library_documents, -> { where.not(type_of_pdf_group: 'Student Forms') }
  scope :student_forms, -> { where(type_of_pdf_group: 'Student Forms') }

  def to_s
    name
  end

  def url
    Rails.application.routes.url_helpers.rails_blob_url(pdf, only_path: true) if pdf.attached?
  end
end
