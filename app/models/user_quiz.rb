class UserQuiz < ActiveRecord::Base
  extend ActiveSupport::Concern
  
  belongs_to :user
  belongs_to :quiz
  has_many   :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  STATUS = %w(not_started started completed)

  included do 
    validates :status, inclusion: {in: STATUS}
  end

end
