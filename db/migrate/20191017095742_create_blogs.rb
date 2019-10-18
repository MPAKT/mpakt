class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.text :title
      t.text :summary
      t.text :description
      t.string :image
      t.boolean :publish

      t.timestamps
    end
  end
end
