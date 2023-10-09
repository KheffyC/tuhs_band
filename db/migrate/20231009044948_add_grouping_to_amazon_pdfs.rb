class AddGroupingToAmazonPdfs < ActiveRecord::Migration[7.0]
  def change
    add_column :amazon_pdfs, :type_of_pdf_group, :string, optional: true
  end
end
