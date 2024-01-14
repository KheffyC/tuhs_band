# == Schema Information
#
# Table name: practice_hub_music_sheets
#
#  id             :bigint           not null, primary key
#  description    :string
#  flat_file_link :string
#  s3_link        :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  collection_id  :bigint
#  flat_file_id   :string
#
# Indexes
#
#  index_practice_hub_music_sheets_on_collection_id  (collection_id)
#
require "test_helper"

class PracticeHub::MusicSheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
