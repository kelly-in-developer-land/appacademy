require_relative 'questions_database'

class QuestionLikes

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      INNER JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL
  end


  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(user_id)
      FROM
        question_likes
      INNER JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL

    results.first.values[0]#refactor please
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      INNER JOIN
        users ON question_likes.user_id = users.id
      INNER JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        title
      ORDER BY
        COUNT(question_likes.user_id)
    SQL
    results[0...n]
  end

  attr_accessor :id, :likes, :question_id, :user_id

  def initialize( options = {} )
    @id, @likes, @question_id, @user_id =
      options.values_at('id', 'likes', 'question_id', 'user_id')
  end

end

if __FILE__ == $PROGRAM_NAME
  p QuestionLikes.liked_questions_for_user_id(1)
  p QuestionLikes.num_likes_for_question_id(2)
end
