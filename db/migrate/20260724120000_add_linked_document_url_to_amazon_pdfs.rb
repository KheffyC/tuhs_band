class AddLinkedDocumentUrlToAmazonPdfs < ActiveRecord::Migration[7.0]
  def change
    add_column :amazon_pdfs, :linked_document_url, :string
  end
end