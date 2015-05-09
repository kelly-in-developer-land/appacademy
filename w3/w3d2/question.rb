require_relative 'questions_database'
require_relative 'question_follows'
require_relative 'question_likes'

class Question

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    results.map { |result| Question.new(result) }
  end

  def self.find_by_id(id)
    Question.all.find { |result| result.id == id }
  end

  def self.find_by_author_id(author_id)
    Question.all.select { |result| result.user_id == author_id }
  end

  def self.most_followed
    QuestionFollows.most_followed_questions(1)
  end

  def self.most_liked
    QuestionLikes.most_liked_questions(1)
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize( options = {} )
    @id, @title, @body, @user_id =
      options.values_at('id', 'title', 'body', 'user_id')
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end

  def likers
    QuestionLikes.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(@id)
  end

  def attrs
    vars = instance_variables.reject { |v| v == :@id if @id.nil? }
    cols = vars.map { |var| var.to_s[1..-1].to_sym }
    attrs = vars.map { |var| instance_variable_get(var) }
    Hash[cols.zip(attrs)]
  end

  def save
    @id.nil? ? create : update
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, attrs)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (:title, :body, :user_id)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
    puts "Created!"
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, attrs.merge({ id: id }))
      UPDATE
        questions
      SET
        title = :title, body = :body, user_id = :user_id
      WHERE
        questions.id = :id
    SQL

    puts "Updated!"
  end


end

if __FILE__ == $PROGRAM_NAME
  # QuestionsDatabase.instance.execute(<<-SQL)
  #   DELETE FROM
  #     questions
  #   WHERE
  #     questions.id > 2
  # SQL
  q = Question.find_by_id(2)
  q.save
  kew = Question.find_by_id(3)
  kew ||= Question.new({ 'title' => 'Smalltalk', 'body' => 'Blah blah weather, right?', 'user_id' => 1 })
  kew.save
end
