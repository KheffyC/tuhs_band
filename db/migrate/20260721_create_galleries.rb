class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.references :school, null: false, foreign_key: true
      t.jsonb :images, default: [], null: false
      t.string :title, null: false, default: "Gallery"
      t.text :description

      t.timestamps
    end
  end
end
