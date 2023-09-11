# == Schema Information
#
# Table name: boosters
#
#  id             :bigint           not null, primary key
#  active         :boolean
#  description    :string
#  email          :string
#  first_name     :string
#  image_url      :string
#  last_name      :string
#  phone_number   :string
#  role           :string
#  years_involved :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  school_id      :bigint           not null
#
# Indexes
#
#  index_boosters_on_school_id  (school_id)
#
# Foreign Keys
#
#  fk_rails_...  (school_id => schools.id)
#
require "test_helper"

class BoosterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
