class User < ActiveRecord::Base
  before_create :generate_api_key

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question
  #  u.liked_questions << q

  has_many :favourites, dependent: :destroy
  has_many :favourited_questions, through: :favourites, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  # ^namespaced questions: so we rename to `liked_question` and then give it the true source `:question`

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # temporarily store password in memory
  # attr_accessor :password
  # attr_accessor :password_confirmation
  # add ^^ attributes for us.
  has_secure_password
  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX


  def full_name
    "#{first_name} #{last_name}".titleize
  end

    private
      # options: SecureRandom.hex,
      def generate_api_key
        self.api_key = SecureRandom.hex(32)
        while User.exists?(api_key: self.api_key)
          self.api_key = SecureRandom.hex(32)
        end
        # begin
        #     self.api_key = SecureRandom.hex(32)
        # end while User.exists?(api_key: self.api_key)
      end
      # we call self because we want to call the actual object. if we don't do do this, we would simply be setting a variable `api_key`.
      # IF WE WANT TO ONLY READ A VALUE, NO NEED TO CALL SELF. BUT IF WE WANT TO WRITE A VALUE, LET'S SELF IT.


end


# http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
# Use bcrypt algorithm
# requires a password_digest attribute
# password must be present
# must be less than 72 characters
# confirmation of password/password_confirmation = ensure they match

# add has_secure_password
# works without confirmation if not provided
