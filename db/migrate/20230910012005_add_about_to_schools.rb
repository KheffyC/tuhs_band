class AddAboutToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :about, :string
  end
end
