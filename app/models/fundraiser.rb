# == Schema Information
#
# Table name: fundraisers
#
#  id             :bigint           not null, primary key
#  call_to_action :string
#  description    :string
#  end_date       :datetime
#  goal           :string
#  main_image     :string
#  start_date     :datetime
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  program_id     :bigint           not null
#
# Indexes
#
#  index_fundraisers_on_program_id  (program_id)
#
# Foreign Keys
#
#  fk_rails_...  (program_id => programs.id)
#
class Fundraiser < ApplicationRecord
  belongs_to :program

  def to_s
    title
  end
end
