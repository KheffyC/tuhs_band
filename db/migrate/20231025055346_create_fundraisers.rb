class CreateFundraisers < ActiveRecord::Migration[7.0]
  def change
    create_table :fundraisers do |t|
      t.string :title
      t.string :description
      t.string :goal
      t.string :call_to_action
      t.string :main_image
      t.belongs_to :program, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
