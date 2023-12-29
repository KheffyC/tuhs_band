class CreatePracticeHubCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_hub_collections do |t|
      t.string :title
      t.belongs_to :section, null: false, foreign_key: { to_table: :practice_hub_sections }

      t.timestamps
    end
  end
end
