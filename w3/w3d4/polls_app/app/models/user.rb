# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  user_name :string
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true

  has_many :authored_polls, class_name: 'Poll', foreign_key: :author_id
  has_many :responses, foreign_key: :user_id
  has_many :answers, through: :responses, source: :answer_choice
end
