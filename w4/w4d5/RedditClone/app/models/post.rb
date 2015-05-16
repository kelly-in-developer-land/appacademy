# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  content    :text
#  sub_id     :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :content, :author_id, presence: true
  belongs_to :author, class_name: 'User'
  has_many :post_subs
  has_many :subreds, through: :post_subs, source: :subred
  has_many :comments

  def comments_by_parent_id
    sorted = {}
    @comments = self.comments
    sorted[:nil] = @comments.select { |c| c.commentable_type == "Post"}
    @comments.reject { |c| c.commentable_type == "Post"}.each do |c|
      sorted[c.commentable_id] = []
      sorted[c.commentable_id] << c
    end
    sorted
  end
end
