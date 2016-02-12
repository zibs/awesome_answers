class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  has_many :comments, dependent: :destroy
  # validate the uniquness of the question to prevent duplicate answers on a single question
  validates :body, presence: true, uniqueness: { scope: :question_id }


  def user_full_name
    user.full_name if user
  end

end
