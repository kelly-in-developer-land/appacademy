class Tagging < ActiveRecord::Base
  validates :tag_topic_id, presence: true
  validates :tagged_url_id, presence: true

  belongs_to(
    :tag_topic,
    class_name: 'TagTopic',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  belongs_to(
    :tagged_url,
    class_name: 'ShortenedURL',
    foreign_key: :tagged_url_id,
    primary_key: :id
  )

  def self.record_tag!(tag_topic, shortened_url)
    Tagging.create!(tagged_url_id: shortened_url.id, tag_topic_id: tag_topic.id)
  end

end
