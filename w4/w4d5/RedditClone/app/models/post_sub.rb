# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  sub_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: true

  belongs_to :post
  belongs_to :subred, class_name: 'Sub', foreign_key: :sub_id
end
