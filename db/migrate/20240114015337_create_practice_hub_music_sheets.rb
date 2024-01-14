class CreatePracticeHubMusicSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_hub_music_sheets do |t|
      t.string :title
      t.string :description
      t.string :flat_file_id
      t.string :flat_file_link
      t.string :s3_link
      t.belongs_to :collection

      t.timestamps
    end
  end
end
