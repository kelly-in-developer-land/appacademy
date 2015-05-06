require_relative 'questions_database'

class Reply

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_id(id)
    Reply.all.find { |result| result.id == id }
  end

  def self.find_by_user_id(user_id)
    Reply.all.select { |result| result.user_id == user_id }
  end

  def self.find_by_question_id(question_id)
    Reply.all.select { |result| result.question_id == question_id }
  end

  attr_accessor :id, :question_id, :user_id, :parent_id, :body

  def initialize( options = {} )
    @id, @question_id, @user_id, @parent_id, @body =
      options.values_at('id', 'question_id', 'user_id', 'parent_id', 'body')
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.all.select { |reply| reply.parent_id == @id }
  end
end
