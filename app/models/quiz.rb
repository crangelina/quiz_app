class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_quiz
  has_many   :questions,    dependent: :destroy
  has_many   :user_quizzes, dependent: :destroy
  accepts_nested_attributes_for :questions

  validates :name, presence: true
end
