class ChangePageImageUrlToAboutImageUrlFromPrograms < ActiveRecord::Migration[7.0]
  def change
    rename_column :programs, :page_image_url, :about_image_url
  end
end
