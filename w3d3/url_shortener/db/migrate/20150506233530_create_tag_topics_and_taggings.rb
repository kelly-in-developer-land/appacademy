class CreateTagTopicsAndTaggings < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic, unique: true
    end

    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :tagged_url_id
    end
  end
end
