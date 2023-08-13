# == Schema Information
#
# Table name: schools
#
#  id          :bigint           not null, primary key
#  city        :string
#  description :string
#  district    :string
#  established :date
#  name        :string(100)      not null
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :bigint
#
# Indexes
#
#  index_schools_on_district_id  (district_id)
#  index_schools_on_name         (name)
#
# Foreign Keys
#
#  fk_rails_...  (district_id => districts.id)
#
require "test_helper"

class SchoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
