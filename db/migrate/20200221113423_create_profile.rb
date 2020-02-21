class CreateProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user

      t.string :url
      t.string :facebook
      t.string :instagram
      t.string :twitter

      t.string :description
      t.string :role

      t.text :summary
      t.string :interests
    end
  end
end
