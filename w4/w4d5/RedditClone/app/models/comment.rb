# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commenter_id     :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :commenter_id, presence: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :commenter, class_name: 'User'
  belongs_to :post
  default_scope { order(id: :desc) }
end
