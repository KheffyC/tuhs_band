class AddDefaultImageToSchool < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :default_image, :string
  end
end
