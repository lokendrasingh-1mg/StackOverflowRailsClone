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

2.upto(4) do |i|
  question.update(heading: "ruby on rails latest version, Version #{i}")
end

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

question.user_votes.create!(
  vote_type: 1,
  user: first_user,
)

answer.user_votes.create!(
  vote_type: 1,
  user: first_user,
)

comment_on_q.user_votes.create!(
  vote_type: 1,
  user: first_user,
)

comment_on_a.user_votes.create!(
  vote_type: 1,
  user: first_user,
)

first_user.bookmark_questions << question

# TODO: use insert_all

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@foo.org"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end

users = User.order(:created_at).take(6)
10.times do
  heading = Faker::Lorem.sentence(word_count: 5)
  description = Faker::Lorem.sentence(word_count: 50)
  users.each { |user| user.questions.create!(heading: heading, description: description) }
end

users.each do |user|
  user.questions.each do |question|
    10.times do
      content = Faker::Lorem.sentence(word_count: 50)
      random_user = users.sample
      question.answers.create!(content: content, user: random_user)
    end
  end
end
