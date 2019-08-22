class UpdateUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :moderator, :integer
    add_column :users, :volunteer, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
