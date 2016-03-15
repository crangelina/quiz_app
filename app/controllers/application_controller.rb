class ApplicationController < ActionController::Base
  require "pp"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def require_teacher
    @user = current_user
    unless @user.role == "teacher"
      return redirect_to user_quizzes_path
    end
  end

  def require_student
    @user = current_user
    unless @user.role == "student"
      return redirect_to quizzes_path
    end
  end


end
