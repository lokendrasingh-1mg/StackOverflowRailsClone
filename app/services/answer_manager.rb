class AnswerManager
  def initialize(answer, user)
    self.answer = answer
    self.user = user
  end

  # Create/ update vote & update the total vote count using sidekiq
  def update_vote!(vote_type)
    answer_vote = Vote::AnswerVote.new(answer, user: user)
    answer_vote.vote_update(vote_type)
    answer_vote.total_vote_count
  end

  private

  attr_accessor :answer, :user
end
