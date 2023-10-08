class CreateAmazonPdfs < ActiveRecord::Migration[7.0]
  def change
    create_table :amazon_pdfs do |t|
      t.string :name
      t.belongs_to :director, null: true, foreign_key: true
      t.belongs_to :program, null: true, foreign_key: true

      t.timestamps
    end
  end
end
