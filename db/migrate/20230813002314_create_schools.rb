class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false, index: true, limit: 100
      t.date :established
      t.string :description
      t.string :city
      t.string :state
      t.string :district

      t.timestamps
    end
  end
end
