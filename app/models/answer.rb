class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy
  # validate the uniquness of the question to prevent duplicate answers on a single question
  validates :body, presence: true, uniqueness: { scope: :question_id }
end
