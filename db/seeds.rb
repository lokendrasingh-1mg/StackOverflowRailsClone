# frozen_string_literal: true

first_user = User.create!(
  name: 'John Doe',
  email: 'john@foo.bar',
  password: 'secret',
  password_confirmation: 'secret'
)

question = first_user.questions.create!(
  heading: 'ruby on rails latest version',
  description: 'ror latest version',
  votes: 1,
)

answer = question.answers.create!(
  content: 'ROR latest stable is 6.1.4',
  user: first_user,
  votes: 1,
)

# TODO: good practice to pass output of one function to another or introduce a variable?
languages = %w[ruby python java js c c++ ruby go]
Tag.insert_all(languages.map { |lang| { name: lang } })
tags = Tag.all

question.tags << tags.sample(3)
first_user.tags << tags.sample(3)

comment_on_q = question.comments.create!(
  content: 'Nice question',
  user: first_user,
  votes: 1,
)

comment_on_a = answer.comments.create!(
  content: 'Nice answer',
  user: first_user,
  votes: 1,
)

question.uservotes.create!(
  value: 1,
  user: first_user,
)

answer.uservotes.create!(
  value: 1,
  user: first_user,
)

comment_on_q.uservotes.create!(
  value: 1,
  user: first_user,
)

comment_on_a.uservotes.create!(
  value: 1,
  user: first_user,
)

first_user.bookmark_questions << question
