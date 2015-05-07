# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :string
#  question_id :integer
#

class AnswerChoice < ActiveRecord::Base
  validates :text, uniqueness: { scope: :question_id }

  belongs_to :question, foreign_key: :question_id
  has_many :responses, foreign_key: :answer_choice_id
  has_many :respondents, through: :responses, source: :respondent

end
