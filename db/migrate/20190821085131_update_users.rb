class UpdateUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :moderator, :integer
    add_column :users, :moderator, :boolean
    add_column :users, :admin, :boolean
  end
end
