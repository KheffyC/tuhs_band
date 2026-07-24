class AddAboutHeroImageToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :about_hero_image, :string
  end
end