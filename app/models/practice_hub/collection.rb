# == Schema Information
#
# Table name: practice_hub_collections
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :bigint           not null
#
# Indexes
#
#  index_practice_hub_collections_on_section_id  (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => practice_hub_sections.id)
#
class PracticeHub::Collection < ApplicationRecord
  belongs_to :section, class_name: 'PracticeHub::Section', inverse_of: :collections

  validates :title, presence: true
end
