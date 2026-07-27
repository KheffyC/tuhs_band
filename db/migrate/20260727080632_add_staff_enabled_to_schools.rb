class AddStaffEnabledToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :staff_enabled, :boolean, default: false, null: false
  end
end
