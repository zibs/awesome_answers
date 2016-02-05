class Question < ActiveRecord::Base
  # adding validation
  validates :title, presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 255 }
            # uniqueness: {case_sensitive: false},

  # specify err msg
  validates :body, presence: true, uniqueness: {message: "must be unique"}

  # this validates that the combination of the title and the body are unique. This means that neither the title nor the body have to be unique by themselves. However, their combination is to be unique.
  validates :title, uniqueness: {scope: :body}

  # validates :view_count, numericality: true
  validates :view_count, numericality: { greater_than_or_equal_to: 0 }

  # using custom validation methods. We must make sure that 'no monkey' is a method available for our class. The method can be public or private, but should be private since we don't need to use it outside this class.
  validate :no_monkey

  after_initialize :set_defaults
  before_save :capitalize_title

  # simple class methods that AR can use to make queries
  # def self.recent(num = 5)
  #   order("created_at DESC").limit(num)
  # end
  # OR USE SCOPES
  # scope: recent, lambda, method -- methods that encapsulate db query.
  # scope :recent,  lambda {|num| order("created_at DESC").limit(num) }
    scope :recent, -> (number = 5){ order("created_at DESC").limit(number) }

  def self.search(term)
    where(["title ILIKE ? OR body ILIKE ?", "%#{term}%", "%#{term}%"]).order("view_count DESC")
  end

    private

      def set_defaults
        self.view_count ||= 0
      end

      def capitalize_title
        self.title.titleize
      end

      def no_monkey
        if title && title.downcase.include?("monkey")
          # two fields, error on attr, message
          errors.add(:title, "No monkey!!")
        end
      end

  # validates(:body, {uniqueness: {message: "must be unique"}})

  # DSL: Domain Specific Language:
  # the code we use is completely valid Ruby,
  # but the method naming and arguments are specific to Active Record.
  # validates :title, presence: true, uniqueness: { case_sensitive: false }

end
