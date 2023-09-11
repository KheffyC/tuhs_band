class CreateBoosters < ActiveRecord::Migration[7.0]
  def change
    create_table :boosters do |t|
      t.boolean :active
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :description
      t.string :image_url
      t.belongs_to :school, null: false, foreign_key: true
      t.string :email
      t.string :phone_number
      t.integer :years_involved

      t.timestamps
    end
  end
end
