class AddAbsenceFormsToSchool < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :performance_absence_form, :string
    add_column :schools, :rehearsal_absence_form, :string
    add_column :schools, :handbook_contract_form, :string
  end
end
