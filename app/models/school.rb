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
class School < ApplicationRecord
    belongs_to :district, optional: true
    has_many :programs, dependent: :destroy

    def to_s 
        name 
    end

    def location 
        "#{city}, #{state}"
    end
end
