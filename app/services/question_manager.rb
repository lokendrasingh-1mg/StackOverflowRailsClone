class QuestionManager
  include Vote

  def initialize(question, user)
    self.question = question
    self.user = user
  end

  # Create/ update vote & update the total vote count using sidekiq
  def update_vote!(vote_type)
    question_vote = QuestionVote.new(question, user: user)
    question_vote.vote_update(vote_type)
  end

  private

  attr_accessor :question, :user
end
