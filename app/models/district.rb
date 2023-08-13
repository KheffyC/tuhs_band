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
class District < ApplicationRecord
    has_many :schools, dependent: :destroy
    has_many :programs, through: :schools
end
