class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :content
      t.integer :sub_id
      t.integer :author_id

      t.timestamps null: false
    end
    add_index :posts, [:sub_id, :author_id]
  end
end
