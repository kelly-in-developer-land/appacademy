class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    create_table :albums do |t|
      t.string :name, null: false
      t.string :set, null: false
      t.integer :band_id, null: false

      t.timestamps null: false
    end
    create_table :tracks do |t|
      t.string :title, null: false
      t.string :status, null: false
      t.text :lyrics
      t.integer :album_id, null: false

      t.timestamps null: false
    end

    add_index :bands, :name
    add_index :albums, [:name, :band_id]
    add_index :tracks, [:title, :album_id]
  end
end
