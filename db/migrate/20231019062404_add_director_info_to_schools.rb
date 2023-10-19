class AddDirectorInfoToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :director_name, :string, limit: 255
    add_column :schools, :director_phone, :string, limit: 255
    add_column :schools, :director_email, :string, limit: 255
    add_column :schools, :percussion_director_name, :string, limit: 255
    add_column :schools, :percussion_director_phone, :string, limit: 255
    add_column :schools, :percussion_director_email, :string, limit: 255
  end
end
