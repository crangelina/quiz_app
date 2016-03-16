class ChangeColumnGradeOnUserQuizzes < ActiveRecord::Migration
  def change
    change_column :user_quizzes, :grade, :string
  end
end
