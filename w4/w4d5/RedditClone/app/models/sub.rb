# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  belongs_to :moderator, class_name: 'User'
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator, class_name: 'User'
  # has_many :posts

  has_many :post_subs
  has_many :posts, through: :post_subs
end
