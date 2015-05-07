# == Schema Information
#
# Table name: polls
#
#  id        :integer          not null, primary key
#  title     :string
#  author_id :integer
#

class Poll < ActiveRecord::Base
  validates :title, uniqueness: :true

  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :questions, foreign_key: :poll_id

end
