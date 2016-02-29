class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user_id, :question_id, presence: true
  validates :user_id, uniqueness: { scope: :question_id }
  # this ensures that the user_id / question_id combination is unique which means users can only like a particular question once.
end
