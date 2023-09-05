# == Schema Information
#
# Table name: districts
#
#  id          :bigint           not null, primary key
#  city        :string
#  description :string
#  name        :string(100)      not null
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_districts_on_name  (name)
#
require "test_helper"

class DistrictTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
