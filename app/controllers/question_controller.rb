class QuestionController < ApplicationController
  def index
    @questions = Question.all
    render json: @questions
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
