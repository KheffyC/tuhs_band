class AddHomeImageUrlToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :main_gallery_image_url, :string
    add_column :programs, :page_image_url, :string
  end
end
