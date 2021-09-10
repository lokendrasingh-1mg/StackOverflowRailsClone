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

# TODO: discuss convention [] vs ()
# map vs each
%w[Ruby Python Java JS].map { |lang| Tag.create!(name: lang) }

question.comments.create!(
  content: 'Nice question',
  user: User.first,
  votes: 1,
)
answer.comments.create!(
  content: 'Nice answer',
  user: User.first,
  votes: 1,
)
