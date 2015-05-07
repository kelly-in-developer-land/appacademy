# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  text    :string
#  poll_id :integer
#

class Question < ActiveRecord::Base
  validates :text, uniqueness: { scope: :poll_id }

  has_many :answer_choices, foreign_key: :question_id
  belongs_to :poll, foreign_key: :poll_id
  has_many :responses, through: :answer_choices

  def results

    # # N + 1 query
    # results = {}
    # answer_choices.each do |choice|
    #   results[choice] = choice.responses.count
    # end
    #
    # results

    # # includes
    # choices_with_responses = answer_choices.includes(:responses)
    # results = {}
    # choices_with_responses.each do |choice|
    #   results[choice] = choice.responses.count
    # end
    #
    # results

    AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT answer_choices.*
      FROM responses
      LEFT OUTER JOIN answer_choices ON responses.answer_choice_id = answer_choices.id
      LEFT OUTER JOIN questions ON questions.id = question_id
      WHERE question_id = ?

    SQL
  end

end
