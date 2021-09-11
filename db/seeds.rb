# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  name: 'John Doe',
  email: 'john@foo.bar',
  password: 'secret',
  password_confirmation: 'secret'
)

question = user.questions.create!(
  heading: 'ruby on rails latest version',
  description: 'ror latest version',
  votes: 1,
)

answer = question.answers.create!(
  content: 'ROR latest stable is 6.1.4',
  user: User.first,
  votes: 1,
)

# TODO: good practice to pass output of one function to another or introduce a variable?
Tag.insert_all_normalized(%w[Ruby Python Java JS].map { |lang| { name: lang.downcase! } })

comment_on_q = question.comments.create!(
  content: 'Nice question',
  user: User.first,
  votes: 1,
)

comment_on_a = answer.comments.create!(
  content: 'Nice answer',
  user: User.first,
  votes: 1,
)

question.uservotes.create!(
  value: 1,
  user: User.first,
)

answer.uservotes.create!(
  value: 1,
  user: User.first,
)

comment_on_q.uservotes.create!(
  value: 1,
  user: User.first,
)

comment_on_a.uservotes.create!(
  value: 1,
  user: User.first,
)
