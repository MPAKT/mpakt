class CreatePrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :privileges do |t|
      t.integer :salary
      t.integer :year

      t.timestamps
    end

    create_table :categories do |t|
      t.integer :name
      t.integer :a
      t.integer :b
      t.integer :c
      t.integer :d
      t.integer :e

      t.references :privileges
    end
  end
end
