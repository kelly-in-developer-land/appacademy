# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: 'Aaron')
User.create!(user_name: 'Kelly')

Poll.create!(title: 'Modes of transportation.',
                author_id: User.find_by_user_name('Kelly').id)

Question.create!(text: 'Which is the coolest?', poll_id: 1)

AnswerChoice.create!(text: 'bike', question_id:  1)
AnswerChoice.create!(text: 'car', question_id:  1)
AnswerChoice.create!(text: 'bus', question_id:  1)

Response.create!(answer_choice_id: 1, user_id: 1)
# Response.create!(answer_choice_id: 3, user_id: 1)
