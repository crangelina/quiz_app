class AddPlaceholderCodeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :placeholder_code, :text
  end
end
