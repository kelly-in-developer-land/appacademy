require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follows'
require_relative 'question_likes'

class User

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end

  def self.find_by_id(id)
    User.all.find { |result| result.id == id }
  end

  def self.find_by_name(fname, lname)
    User.all.find do |result|
      result.fname == fname && result.lname == lname
    end
  end

  attr_accessor :id, :fname, :lname

  def initialize( options = {} )
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end

  # def average_karma_ruby_sql
  #   total = 0
  #   user_questions = Question.find_by_author_id(@id)
  #   user_questions.each do |question|
  #     total += QuestionLikes.num_likes_for_question_id(question.id)
  #   end
  #
  #   total / user_questions.count
  # end

  def average_karma_sql

    user = @id

    results = QuestionsDatabase.instance.execute(<<-SQL, user)

      SELECT
        COUNT(DISTINCT(question_id)), CAST(COUNT(likes) AS FLOAT)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
      GROUP BY
        likes

    SQL

    likes, questions = results.first[1], results.first[0]
    likes / questions

  end

  def save

  end


end

if __FILE__ == $PROGRAM_NAME
  u = User.find_by_id(2)
  p u.average_karma_sql
end
