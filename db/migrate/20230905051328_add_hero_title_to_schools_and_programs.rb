class AddHeroTitleToSchoolsAndPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :hero_title, :string, limit: 100
    add_column :programs, :hero_title, :string, limit: 100
    add_column :schools, :call_to_action, :string
    add_column :programs, :detailed_description, :string
  end
end
