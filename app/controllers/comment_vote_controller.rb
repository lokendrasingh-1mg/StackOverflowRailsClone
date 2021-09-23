class CommentVoteController < ApplicationController
  include Votable

  before_action :validate_votes

  private

  def manager
    @manager ||= CommentManager.new(resource, user)
  end

  def klass
    Comment
  end

  def resource
    @resource ||= klass.find(params[:id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def id
    @id ||= params[:id]
  end

  def validate_votes
    param! :id, Integer, required: true
  end
end
