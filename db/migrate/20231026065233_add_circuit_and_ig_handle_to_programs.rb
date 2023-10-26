class AddCircuitAndIgHandleToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :circuit, :string, limit: 50
    add_column :programs, :ig_handle, :string, limit: 50
  end
end
