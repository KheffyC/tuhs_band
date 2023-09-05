class AddDistrictIdToSchools < ActiveRecord::Migration[7.0]
  def change
    add_reference :schools, :district, null: true, foreign_key: true
  end
end
