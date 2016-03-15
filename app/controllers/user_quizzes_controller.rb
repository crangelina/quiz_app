class UserQuizzesController < ApplicationController

  require "pp"

  before_filter :require_teacher, only: [:new, :create, :destroy]
  before_filter :require_student, only: [:index, :start, :show, :update]

  ## STUDENT
  def index 
  end

  def start
    @user_quiz = UserQuiz.find(params[:id])
    @user_quiz.status = "started"
    @user_quiz.quiz.questions.each do |question|
      @user_quiz.answers.create(question_id: question.id)
    end
    @user_quiz.save

    redirect_to action: "show"
  end

  def show
    @user_quiz = UserQuiz.find(params[:id])
  end

  def update
    @user_quiz = UserQuiz.find(params[:id])
    if params[:commit] == "Complete"
      @user_quiz.status = "completed"
    end
    if @user_quiz.update_attributes(user_quiz_params)
      redirect_to action: "index"
    else 
      render action: "show"
    end
  end



  ## TEACHER
  def new
    @user_quiz = UserQuiz.new
  end

  def create
    @user_quiz = UserQuiz.new(user_quiz_params)
    if @user_quiz.save
      flash[:notice] = "The quiz was successfully assigned."
      redirect_to controller: "quizzes", action: "index"
    else
      flash.now[:notice] = "The quiz could not be assigned."
      render action: 'new'
    end
  end

  def grade
    @user_quiz = UserQuiz.find(params[:id])
    if @user_quiz.update_attributes(user_quiz_params)
      p "-" * 50
      pp params
      p "-" * 50
      flash[:notice] = "The quiz was successfully graded."
      redirect_to controller: "quizzes", action: "index"
    else
      flash[:notice] = "The quiz could not be graded."
      redirect_to controller: "quizzes", action: "review"
    end
  end

  def destroy
    @user_quiz = UserQuiz.find(params[:id])
    @user_quiz.destroy
    flash[:notice] = "The quiz has been successfully unassigned."
    redirect_to controller: "quizzes", action: "index"
  end




  private

  def user_quiz_params
    params.require(:user_quiz).permit(
      :user_id, 
      :quiz_id,
      :answers_attributes => [:id, :question_id, :user_quiz_id, :value, :is_correct]
      )
  end


end
