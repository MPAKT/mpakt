class AddFieldsToPrivileges < ActiveRecord::Migration[5.2]
  def change
    add_column :privileges, :country_code, :text
    add_column :privileges, :redundancy, :integer
    add_column :privileges, :role, :text
    add_column :privileges, :salary_year, :integer
  end
end
