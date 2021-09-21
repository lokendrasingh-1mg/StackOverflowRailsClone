module Vote
  class Base < ApplicationService
    def initialize(obj, user: nil)
      self.obj = obj
      self.user = user
    end

    private

    attr_accessor :obj, :user

    def votable_entity
      @votable_entity ||= obj.user_votes.find_or_initialize_by(user: user)
    end
  end
end
