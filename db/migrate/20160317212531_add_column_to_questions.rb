class AddColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :answer_type, :string
    add_column :questions, :answer_language, :string
  end
end
