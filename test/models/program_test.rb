# == Schema Information
#
# Table name: programs
#
#  id                     :bigint           not null, primary key
#  description            :string
#  main_gallery_image_url :string
#  name                   :string(100)      not null
#  page_image_url         :string
#  year_established       :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  school_id              :bigint           not null
#
# Indexes
#
#  index_programs_on_name       (name)
#  index_programs_on_school_id  (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
require "test_helper"

class ProgramTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
