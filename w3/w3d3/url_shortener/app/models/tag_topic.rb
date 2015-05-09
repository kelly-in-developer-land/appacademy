class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  has_many(
    :tagged_urls,
    through: :taggings,
    source: :tagged_url
  )

  def most_popular_links
    all_tagged_links = Hash.new { |h, k| h[k] = 0 }
    self.tagged_urls.group(:long_url).each do |link|
      all_tagged_links[link.long_url] = link.num_uniques
    end
    tagged_links_array = all_tagged_links.sort_by { |k, v| v }
    tagged_links_array.reverse[0..5].flatten
  end

end
