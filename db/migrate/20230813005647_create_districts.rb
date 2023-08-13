class CreateDistricts < ActiveRecord::Migration[7.0]
  def change
    create_table :districts do |t|
      t.string :name, null: false, index: true, limit: 100
      t.string :city
      t.string :state
      t.string :description

      t.timestamps
    end
  end
end
