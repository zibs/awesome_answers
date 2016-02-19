class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :question

  # we want tags to have both question/tag id
  # validates :tag_id, :question_id, presence: true
  # we don't want the same question to have duplicate tags
  validates :tag_id, uniqueness: { scope: :question_id }
end


# q.tag_ids = [2,3] the tag ids to associate a question with
