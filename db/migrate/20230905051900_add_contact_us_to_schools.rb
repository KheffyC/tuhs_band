class AddContactUsToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :contact_us, :string
  end
end
