class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :post_id
      t.integer :sub_id

      t.timestamps null: false
    end

    add_index(:post_subs, [:post_id, :sub_id])
  end
end
