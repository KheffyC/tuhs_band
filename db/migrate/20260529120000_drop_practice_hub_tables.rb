class DropPracticeHubTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :practice_hub_music_sheets, if_exists: true
    drop_table :practice_hub_collections, if_exists: true
    drop_table :practice_hub_sections, if_exists: true
  end

  def down
    create_table :practice_hub_sections do |t|
      t.string :name
      t.string :instrument
      t.belongs_to :program, foreign_key: true

      t.timestamps
    end

    create_table :practice_hub_collections do |t|
      t.string :title
      t.belongs_to :section, null: false, foreign_key: { to_table: :practice_hub_sections }

      t.timestamps
    end

    create_table :practice_hub_music_sheets do |t|
      t.string :title
      t.string :description
      t.string :flat_file_id
      t.string :flat_file_link
      t.string :s3_link
      t.belongs_to :collection, foreign_key: { to_table: :practice_hub_collections }

      t.timestamps
    end
  end
end