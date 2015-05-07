# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#

class Response < ActiveRecord::Base

  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

  belongs_to :answer_choice, foreign_key: :answer_choice_id
  belongs_to :respondent, class_name: 'User', foreign_key: :user_id
  has_one :question, through: :answer_choice

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(['user_id = ?', user_id])
      errors.add(:extant_response, "User already responded to that question!")
    end
  end

  def respondent_is_not_author
    if question.poll.author == respondent
      errors.add(:respondent_is_author, "Author cannot respond to their own poll!")
    end
  end


  def sibling_responses
    question.responses.where('responses.id != ? OR ? IS NULL', id, id)
  end

end
