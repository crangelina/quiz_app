class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many   :answers

  after_save :nullify_language

  accepts_nested_attributes_for :answers

  ANSWER_TYPES = %w(Text Code)
  ANSWER_LANGUAGES = %w(JavaScript Ruby)

  private

    def nullify_language
      if self.answer_type == "Text"
        self.update_column(:answer_language, nil)
      end
    end
end
