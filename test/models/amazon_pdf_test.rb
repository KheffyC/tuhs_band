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
require "test_helper"

class AmazonPdfTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
