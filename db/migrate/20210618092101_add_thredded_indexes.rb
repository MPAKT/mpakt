class AddThreddedIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :thredded_private_posts, :user_id
    add_index :thredded_private_topics, :user_id
  end
end
