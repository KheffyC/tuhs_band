class AddImageGalleryUrlsToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :image_gallery_urls, :string
  end
end
