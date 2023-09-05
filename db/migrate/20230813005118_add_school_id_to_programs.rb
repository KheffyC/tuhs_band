class AddSchoolIdToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_reference :programs, :school, null: false, foreign_key: true
  end
end
