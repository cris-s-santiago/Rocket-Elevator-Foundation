class AddUserToEmployees < ActiveRecord::Migration[5.2]
  def change
    # add_reference(table_name, ref_name, options = {})
    # Basically says add a reference in :employees to :user, and that reference is a foreign key
    add_reference :employees, :user, foreign_key: true
  end
end
