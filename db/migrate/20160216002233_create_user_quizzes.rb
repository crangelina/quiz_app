class CreateUserQuizzes < ActiveRecord::Migration
  def change
    create_table :user_quizzes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :quiz, index: true, foreign_key: true
      t.string :status,   default: "not_started"

      t.timestamps null: false
    end
  end
end
