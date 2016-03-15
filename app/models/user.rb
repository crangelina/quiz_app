class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :quizzes, dependent: :destroy
  has_many :user_quizzes

  scope :students, -> { where(role: 'student') }

  def full_name
    "#{first_name} #{last_name}"
  end

end
