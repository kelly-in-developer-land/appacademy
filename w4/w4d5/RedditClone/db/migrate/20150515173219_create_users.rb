class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :session_token
      t.string :password_digest

      t.timestamps null: false
    end

    add_index(:users, :session_token, unique: true)
    add_index(:users, :password_digest, unique: true)
  end
end
