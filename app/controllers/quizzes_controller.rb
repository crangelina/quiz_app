class QuizzesController < ApplicationController

  before_filter :require_teacher
  before_filter :set_quiz, only: [:show, :update, :destroy]

  def index
    @quizzes = @user.quizzes
  end

  def show
  end

  def update
    if @quiz.update_attributes(quiz_params)
      redirect_to action: "index"
    else 
      render action: "show"
    end
  end

  def new
    @quiz = @user.quizzes.new
    @quiz.questions.build
  end

  def create
    @quiz = @user.quizzes.new(quiz_params)
    if @quiz.save
      flash[:notice] = "The quiz was successfully created."
      redirect_to action: "index"
    else
      flash.now[:notice] = "The quiz could not be created. Please provide a name for the quiz."
      render action: "new"
    end
  end

  def review
    @user_quiz = UserQuiz.find(params[:id])
  end

  def destroy
    @quiz.destroy
    flash[:notice] = "The quiz has been successfully deleted."
    redirect_to root_path
  end




  private

    def quiz_params
      params.require(:quiz).permit(
        :name, 
        :instructions, 
        :user_id,
        :questions_attributes => [:name, :expected_answer, :instructions, :id],
        :answers_attributes => [:id, :question_id, :user_quiz_id, :value]
        )
    end

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

end




