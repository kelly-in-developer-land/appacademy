require_relative 'questions_database'

class QuestionFollows

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    results.map { |result| QuestionFollows.new(result) }
  end

  def self.find_by_id(id)
    QuestionFollows.all.find { |result| result.id == id }
  end

  def self.followers_for_question_id(question_id)

    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      INNER JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL

  end

  def self.followed_questions_for_user_id(user_id)

    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      INNER JOIN
        users ON question_follows.user_id = users.id
      INNER JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        title
      ORDER BY
        COUNT(question_follows.user_id)
    SQL
    results[0...n]
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id, @question_id, @user_id =
      options.values_at('id', 'question_id', 'user_id')
  end

end

if __FILE__ == $PROGRAM_NAME
  p QuestionFollows.most_followed_questions(2)
end
