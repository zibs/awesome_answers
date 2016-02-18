class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: { scope: :question_id}


  def question_title(id)
    Question.find(id).title
  end

end
