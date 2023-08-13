class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.string :name, null: false, index: true, limit: 100
      t.string :description
      t.date :year_established

      t.timestamps
    end
  end
end
