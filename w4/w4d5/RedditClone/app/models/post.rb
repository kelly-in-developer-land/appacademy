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
  # belongs_to :subred, class_name: 'Sub', foreign_key: :sub_id
  belongs_to :author, class_name: 'User'
  has_many :post_subs
  has_many :subreds, through: :post_subs, source: :subred
  has_many :comments, as: :commentable
end
