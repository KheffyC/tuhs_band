class AddCalendarUrlToProgramsAndSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :calendar_url, :string
    add_column :schools, :calendar_url, :string
  end
end
