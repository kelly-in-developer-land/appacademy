class Visit < ActiveRecord::Base
  validates :visit_url_id, presence: true
  validates :visitor_id, presence: true

  belongs_to(
    :url,
    class_name: 'ShortenedURL',
    foreign_key: :visit_url_id,
    primary_key: :id
  )

  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :visitor_id,
    primary_key: :id
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(visit_url_id: shortened_url.id, visitor_id: user.id)
  end

end
