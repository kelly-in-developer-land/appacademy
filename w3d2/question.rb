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

  def save
    if @id.nil?
      create
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      update
    end
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL

    p "Created!"
  end

  def update
    id = @id

    QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id, id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        questions.id = ?
    SQL

    p "Updated!"
  end

end

if __FILE__ == $PROGRAM_NAME
  q = Question.find_by_id(2)
  q.save
end

# results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
# question = results.create({ :title => 'Using BART', :body => 'Does anyone know how to use public transit?', :user_id =>1 })
