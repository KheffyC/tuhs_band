class AddProgramSupportTextToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :program_support_text, :text
  end
end
