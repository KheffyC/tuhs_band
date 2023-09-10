# == Schema Information
#
# Table name: abouts
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  school_id   :bigint           not null
#
# Indexes
#
#  index_abouts_on_school_id  (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
require "test_helper"

class AboutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
