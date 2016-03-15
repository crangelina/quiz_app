class AddGradeToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :grade, :integer
  end
end
