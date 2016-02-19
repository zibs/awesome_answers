class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :question_id, uniqueness: { scope:  :user_id }
  scope :up_count, -> { where(up: true).count }
  scope :down_count, -> { where(up: false).count }

  # scope :name , ->(defaults=?){AR_query}
end
