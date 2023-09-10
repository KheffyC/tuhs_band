class AddHomePageImagesToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :home_page_image_urls, :string
  end
end
