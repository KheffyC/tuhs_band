# == Schema Information
#
# Table name: practice_hub_sections
#
#  id         :bigint           not null, primary key
#  instrument :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  program_id :bigint
#
# Indexes
#
#  index_practice_hub_sections_on_program_id  (program_id)
#
# Foreign Keys
#
#  fk_rails_...  (program_id => programs.id)
#
require "test_helper"

class PracticeHub::SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
