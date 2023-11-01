class AddEventDateToAmazonPdfs < ActiveRecord::Migration[7.0]
  def change
    add_column :amazon_pdfs, :event_date, :date, default: nil, optional: true
  end
end
