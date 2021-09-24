class QuestionManager
  def initialize(question, user)
    self.question = question
    self.user = user
  end

  # Create/ update vote & update the total vote count using sidekiq
  def update_vote!(vote_type)
    question_vote = Vote::QuestionVote.new(question, user: user)
    result = question_vote.vote_update(vote_type)
    VoteUpdateWorker.perform_async(question.id, 'Question')
    result
  end

  private

  attr_accessor :question, :user
end
