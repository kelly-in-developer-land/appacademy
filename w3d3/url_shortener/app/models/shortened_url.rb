class ShortenedURL < ActiveRecord::Base
  validates :long_url, presence: true, length: { maximum: 60 }
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  validate :submitter_id, :max_submissions

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )


  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visit_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tagged_url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )


  def self.random_code
    code = SecureRandom.urlsafe_base64
    ShortenedURL.random_code if ShortenedURL.exists?(short_url: code)

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedURL.random_code
    ShortenedURL.create!(
      {long_url: long_url, short_url: short_url, submitter_id: user.id}
      )
  end

  def num_clicks
    self.visits.count
  end

  def num_recent_uniques
    visitors.where(["visits.created_at > ?", 10.minutes.ago]).count
  end

  def num_uniques
    visitors.count
  end

  def max_submissions
    user = User.find(submitter_id)
    sub_count_last_min =
      user.submitted_urls.where(["created_at > ?", 1.minutes.ago]).count
    raise "You're submitting too many links!" unless sub_count_last_min < 5

    true
  end

end
