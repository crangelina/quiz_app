class AddIsCorrectToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :is_correct, :boolean, default: false
  end
end
