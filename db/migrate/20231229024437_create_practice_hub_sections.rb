class CreatePracticeHubSections < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_hub_sections do |t|
      t.string :name
      t.string :instrument
      t.belongs_to :program, null: true, foreign_key: true

      t.timestamps
    end
  end
end
