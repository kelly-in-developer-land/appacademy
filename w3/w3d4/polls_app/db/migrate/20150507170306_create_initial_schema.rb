class CreateInitialSchema < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
    end
    add_index :users, :user_name, unique: true

    create_table :polls do |t|
      t.string :title
      t.integer :author_id
    end
    add_index :polls, :title, unique: true

    create_table :questions do |t|
      t.string :text
      t.integer :poll_id
    end
    add_index :questions, [:poll_id, :text], unique: true

    create_table :answer_choices do |t|
      t.string :text
      t.integer :question_id
    end
    add_index :answer_choices, [:question_id, :text], unique: true

    create_table :responses do |t|
      t.integer :answer_choice_id
      t.integer :user_id
    end
  end
end
