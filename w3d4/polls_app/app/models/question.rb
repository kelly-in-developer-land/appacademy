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

    # choices_with_counts = AnswerChoice.find_by_sql([<<-SQL, id])
    #   SELECT answer_choices.*, COUNT(responses.id) AS response_count
    #   FROM answer_choices
    #   LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id
    #   WHERE question_id = ?
    #   GROUP BY answer_choices.id
    # SQL

    choices_with_counts = self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins(<<-SQL).group("answer_choices.id")
        LEFT OUTER JOIN responses
        ON answer_choices.id = responses.answer_choice_id
      SQL

    outcome = {}
    choices_with_counts.each do |choice|
      outcome[choice.text] = choice.response_count
    end

    outcome

  end

end
