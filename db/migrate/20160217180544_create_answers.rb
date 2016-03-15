class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user_quiz, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.text :value

      t.timestamps null: false
    end
  end
end
