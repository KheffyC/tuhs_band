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
module PracticeHub
  class Section < ApplicationRecord
    belongs_to :program, optional: true, inverse_of: :sections
    has_many :collections, dependent: :destroy, class_name: 'PracticeHub::Collection', inverse_of: :section

    validates :name, :instrument, presence: true
  end
end
