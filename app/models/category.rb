class Category < ActiveRecord::Base
  # after_initialize :set_defaults
  has_many :questions, dependent: :nullify
  validates :name, presence: true, uniqueness: true
end
