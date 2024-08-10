class AddPeriodToEachProgram < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :period, :integer, default: 0
  end
end
